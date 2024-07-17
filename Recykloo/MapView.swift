//
//  MapView.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 17/07/24.
//

import SwiftUI
import MapKit

// Wrapper struct for MKMapItem to conform to Identifiable
struct IdentifiableMKMapItem: Identifiable {
    var id = UUID()
    var mapItem: MKMapItem
}

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var cameraPosition: MKCoordinateRegion = .userRegion
    @State private var searchText = ""
    @State private var results = [IdentifiableMKMapItem]()
    @State private var mapSelection: IdentifiableMKMapItem?

    var body: some View {
        VStack {
            Map(coordinateRegion: $cameraPosition, showsUserLocation: true, annotationItems: results) { item in
                MapAnnotation(coordinate: item.mapItem.placemark.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(item.mapItem.name ?? "")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .overlay(alignment: .top) {
                TextField("Search for a location", text: $searchText)
                    .font(.subheadline)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding()
                    .shadow(radius: 10)
            }
            .onSubmit(of: .text) {
                Task { await searchPlaces() }
            }
            .overlay(alignment: .bottom) {
                HStack {
                    MapCompass()
                    Spacer()
                    MapUserLocationButton()
                }
                .padding()
            }
        }
    }

    private func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = cameraPosition

        do {
            let response = try await MKLocalSearch(request: request).start()
            self.results = response.mapItems.map { IdentifiableMKMapItem(mapItem: $0) }
        } catch {
            print("Search failed: \(error.localizedDescription)")
            self.results = []
        }
    }
}

extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: -7.285507521676576, longitude: 112.6315874013664)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off and to go turn it on.")
        }
    }

    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
