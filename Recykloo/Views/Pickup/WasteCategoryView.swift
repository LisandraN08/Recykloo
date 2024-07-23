//
//  WasteCategory.swift
//  Recykloo
//
//  Created by palpedpad on 17/07/24.
//

import SwiftUI

struct WasteCategoryView: View {
    @State private var searchText: String = ""
    @State private var navigateToPickupFormView = false
    @State private var selectedWastes: [Waste] = []

    let wasteTypes = [
        WasteType(nama: "Botol Plastik", gambar: "waterbottle", poinPerKilo: 10, category: "Plastik"),
        WasteType(nama: "Tas Plastik", gambar: "plastik", poinPerKilo: 8, category: "Plastik"),
        WasteType(nama: "Kardus", gambar: "kardus", poinPerKilo: 5, category: "Kertas"),
        WasteType(nama: "Kaleng", gambar: "kaleng soda", poinPerKilo: 12, category: "Logam")
    ]

    var body: some View {
        NavigationStack {
            VStack {
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        CategoryButton(wasteCategory: "All")
                        CategoryButton(wasteCategory: "Plastik")
                        CategoryButton(wasteCategory: "Kertas")
                        CategoryButton(wasteCategory: "Logam")
                        CategoryButton(wasteCategory: "Kaleng")
                        CategoryButton(wasteCategory: "Kain")
                    }
                }
                .padding(.horizontal, 16)
                
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical) {
                        VStack(spacing: 0) {
                            ForEach(wasteTypes, id: \.nama) { wasteType in
                                WasteCard(selectedWastes: $selectedWastes, wasteType: wasteType)
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    Rectangle()
                        .fill(Color(.systemBackground))
                        .frame(height: 70)
                        .overlay {
                            HStack {
                                Button(action: {
                                    // Code
                                }) {
                                    HStack {
                                        Image(systemName: "list.dash")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 15, height: 15)
                                        Text("Added items")
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                    .buttonStyle(.bordered)
                                    .controlSize(.regular)
                                    .padding(.horizontal, 26)
                                    .padding(.vertical, 12)
                                    .foregroundColor(.primary)
                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 8,
                                            style: .continuous)
                                        .stroke(Color.primary.opacity(0.2), lineWidth: 1)
                                    )
                                }
                                NavigationLink(destination: PickupFormView(selectedWastes: selectedWastes), isActive: $navigateToPickupFormView) {
                                    Button(action: {
                                        navigateToPickupFormView = true
                                    }) {
                                        Text("Continue")
                                            .font(.system(size: 16, weight: .semibold))
                                            .padding(.horizontal, 51)
                                            .padding(.vertical, 12)
                                            .foregroundColor(.white)
                                            .background(Color("Ijo"))
                                            .cornerRadius(8)
                                    }
                                }
                            }
                        }
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
    }
}

struct CategoryButton: View {
    var wasteCategory: String = ""
    
    var body: some View {
        Button(action: {
            // Code
        }) {
            Text(wasteCategory)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .foregroundColor(Color("Ijo"))
                .background(Color("Ijo").opacity(0.1))
                .cornerRadius(50)
        }
    }
}

struct WasteCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        WasteCategoryView()
    }
}
