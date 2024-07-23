//
//  LocationPickerView.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 18/07/24.
//

import SwiftUI

struct LocationPickerView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedLocation: String
    
    let locations = [
        "Kost Green House, Universitas Ciputra",
        "Kampus UBAYA, Surabaya",
        "Plaza Tunjungan, Surabaya",
        "Rumah Sakit Dr. Soetomo, Surabaya"
    ]
    
    var body: some View {
        List(locations, id: \.self) { location in
            Button(action: {
                selectedLocation = location
                presentationMode.wrappedValue.dismiss()
            }) {
                Text(location)
            }
        }
        .navigationTitle("Pilih Lokasi")
    }
}

struct LocationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPickerView(selectedLocation: .constant(""))
    }
}
