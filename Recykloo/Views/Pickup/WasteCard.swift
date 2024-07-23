//
//  WasteCard.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 20/07/24.
//

import SwiftUI

struct WasteCard: View {
    @Binding var selectedWastes: [Waste]
    @State private var digitData = 0.0
    @State var showSheet: Bool = false
    var wasteType: WasteType

    var body: some View {
        Rectangle()
            .fill(Color(.systemBackground))
            .frame(width: 361, height: 136)
            .overlay(
                VStack(spacing: 0) {
                    HStack(spacing: 18) {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(Color(.secondarySystemBackground))
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(wasteType.gambar)
                            )
                            .sheet(isPresented: $showSheet, content: {
                                WasteDetailView(wasteType: wasteType)
                            })
                            .onTapGesture {
                                showSheet.toggle()
                            }
                        VStack(alignment: .leading) {
                            HStack {
                                Text(wasteType.nama)
                                    .font(.system(.title3, weight: .semibold))
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Button {
                                    digitData = 0.0
                                    // Hapus item dari daftar jika ada
                                    selectedWastes.removeAll { $0.wasteType.nama == wasteType.nama }
                                } label: {
                                    Image(systemName: "trash.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .foregroundColor(Color("Ijo"))
                                }
                                .frame(width: 40, height: 40)
                                .background(Color("Ijo").opacity(0.1))
                                .cornerRadius(20)
                                Spacer()
                                CustomStepper(digitData: $digitData)
                                    .onChange(of: digitData) { newValue in
                                        if newValue > 0 {
                                            // Tambah atau perbarui item di daftar
                                            if let index = selectedWastes.firstIndex(where: { $0.wasteType.nama == wasteType.nama }) {
                                                selectedWastes[index].berat = Int(newValue)
                                            } else {
                                                let waste = Waste(wasteType: wasteType, berat: Int(newValue))
                                                selectedWastes.append(waste)
                                            }
                                        } else {
                                            // Hapus item dari daftar jika beratnya nol
                                            selectedWastes.removeAll { $0.wasteType.nama == wasteType.nama }
                                        }
                                    }
                            }
                            .frame(alignment: .trailing)
                        }
                        .frame(alignment: .trailing)
                    }
                    .padding(8)
                    Rectangle()
                        .frame(height: 1)
                        .padding(.horizontal, 10)
                        .opacity(0.2)
                }
            )
    }
}

