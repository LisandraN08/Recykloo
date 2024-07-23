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
    @Binding var selectedLocation: String
    @Environment(\.presentationMode) var presentationMode

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
                    .onTapGesture {
                        selectedLocation = item.mapItem.name ?? "Pakuwon Mall"
                        presentationMode.wrappedValue.dismiss() // Dismiss the view after selecting the location
                    }
                }
            }
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .overlay(alignment: .top) {
                TextField("Search for a location", text: $searchText, onCommit: {
                    Task { await searchPlaces() }
                })
                    .font(.subheadline)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding()
                    .shadow(radius: 10)
            }
            .overlay(alignment: .bottom) {
                HStack {
                    Spacer()
                    Button(action: {
                        if let location = viewModel.locationManager?.location {
                            cameraPosition.center = location.coordinate
                        }
                    }) {
                        Image(systemName: "location.fill")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 10)
                    }
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

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(selectedLocation: .constant(""))
    }
}
