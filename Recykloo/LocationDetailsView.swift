//
//  LocationDetailsView.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 17/07/24.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    @Binding var mapSelection: MKMapItem?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    LocationDetailsView(mapSelection: .constant(nil))
}
