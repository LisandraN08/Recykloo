//
//  MapView.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 17/07/24.
//

import SwiftUI
import MapKit

struct MapItem: Identifiable, Hashable {
    let id = UUID()
    let mapItem: MKMapItem

    static func == (lhs: MapItem, rhs: MapItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var cameraPosition: MKCoordinateRegion = .userRegion
    @State private var searchText = ""
    @State private var results = [MapItem]()
    @State private var mapSelection: MapItem?
    @State private var selectedMapItem: MapItem? = nil
    @State private var showLocationDetails: Bool = false

    var body: some View {
       // NavigationView {
            VStack {
                HStack {
                    Text("Set Pick-up Location")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        // Action for bell icon
                    }) {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                    }
                }
                .padding()
                Map(coordinateRegion: $cameraPosition, showsUserLocation: true, annotationItems: results) { item in
                    MapAnnotation(coordinate: item.mapItem.placemark.coordinate) {
                        VStack {
                            Image("iconCurrentLocation")
                                .resizable()
                                .frame(width:30, height: 30)
                            Text(item.mapItem.name ?? "")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                        .onTapGesture {
                            selectedMapItem = item
                        }
                    }
                }
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                .onChange(of: viewModel.userLocation) { newLocation in
                    if let newLocation = newLocation {
                        cameraPosition.center = newLocation
                    }
                }
                .overlay(alignment: .bottom) {
                    HStack {
                        MapCompass()
                        Spacer()
                        MapUserLocationButton()
                    }
                    .padding()
                }

                VStack(alignment: .leading) {
                    TextField("Search location", text: $searchText)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding()
                        .shadow(radius: 10)
                        .onSubmit(of: .text) {
                            Task { await searchPlaces() }
                        }

                    List {
                        ForEach(results) { item in
                            HStack {
                                Image("iconLocation")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .padding(.trailing, 10)
                                NavigationLink(destination: LocationDetailsView(item: item)) {
                                    VStack(alignment: .leading) {
                                        Text(item.mapItem.name ?? "")
                                            .font(.body)
                                        Text(item.mapItem.placemark.title ?? "")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                //.frame(maxHeight: 400)
                Spacer()
            }
       // }
            .navigationBarTitleDisplayMode(.inline)
    }

    private func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = cameraPosition

        do {
            let response = try await MKLocalSearch(request: request).start()
            self.results = response.mapItems.map { MapItem(mapItem: $0) }
        } catch {
            print("Search failed: \(error.localizedDescription)")
            self.results = []
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

let userLocationCoordinate = CLLocationCoordinate2D(latitude: -7.285507521676576, longitude: 112.6315874013664)

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: userLocationCoordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
