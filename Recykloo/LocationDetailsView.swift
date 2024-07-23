//
//  LocationDetailsView.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 17/07/24.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    let item: MapItem // Make sure `MapItem` is the correct type

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(item.mapItem.name ?? "Unknown Name")
                .font(.largeTitle)
                .padding()

            Text(item.mapItem.placemark.title ?? "Unknown Location")
                .font(.title2)
                .padding(.horizontal)

            Spacer()
        }
        .navigationTitle(item.mapItem.name ?? "Details")
        .padding()
    }
}
