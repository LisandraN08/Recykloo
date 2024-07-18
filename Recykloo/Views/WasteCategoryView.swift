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

    var body: some View {
        NavigationView {
            VStack {
//                HStack {
//                    TextField("Search", text: $searchText)
//                        .padding(8)
//                        .background(Color(.systemGray6))
//                        .cornerRadius(8)
//                        .padding(.horizontal)
//                }
//                .padding(.top)

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
                            WasteCard()
                            WasteCard()
                            WasteCard()
                            WasteCard()
                            WasteCard()
                        }
                        Spacer()
                    }
                    .padding(.bottom, 1)
                    Rectangle()
                        .fill(.white)
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
                                    .foregroundColor(.black)
                                    .background(
                                        RoundedRectangle(
                                            cornerRadius: 8,
                                            style: .continuous)
                                        .stroke(.black.opacity(0.2), lineWidth: 1)
                                    )
                                }
                                NavigationLink(destination: PickupFormView(), isActive: $navigateToPickupFormView) {
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
        .searchable(text: $searchText)
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

struct WasteCard: View {
    @State private var digitData = 0.0
    @State var showSheet: Bool = false

    var body: some View {
        Rectangle()
            .fill(.white)
            .frame(width: 361, height: 136)
            .overlay(
                VStack(spacing: 0) {
                    HStack(spacing: 18) {
                        RoundedRectangle(cornerRadius: 11)
                            .fill(.quaternary)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image("waterbottle")
                            )
                            .sheet(isPresented: $showSheet, content: {
                                WasteDetailView()
                            })
                            .onTapGesture {
                                showSheet.toggle()
                            }
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Botol Plastik")
                                    .font(.system(.title3, weight: .semibold))
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Button {
                                    digitData = 0.0
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
                                Stepper(digitData: $digitData)
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

struct WasteDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var digitData = 0.0

    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Jenis-jenis sampah yang kami terima")
                        .font(.system(size: 16, weight: .medium))
                    Text("Pastikan sampahmu sesuai dengan jenis di bawah yaa!")
                        .font(.system(size: 14, weight: .regular))
                    ScrollView(.horizontal) {
                        HStack {
                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image("waterbottle")
                                    )
                                Text("Botol Plastik")
                                    .font(.system(size: 18, weight: .regular))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(.tertiary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image("waterbottle")
                                    )
                                Text("Botol Plastik")
                                    .font(.system(size: 18, weight: .regular))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(.tertiary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                                    .frame(width: 120, height: 120)
                                    .overlay(
                                        Image("waterbottle")
                                    )
                                Text("Botol Plastik")
                                    .font(.system(size: 18, weight: .regular))
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 10)
                            .background(.tertiary)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    .padding(.bottom, 23)

                    Text("Siapkan sampahmu")
                        .font(.system(size: 16, weight: .medium))
                    Text("Bantu kami dengan mengemas produk dengan bersih")
                        .font(.system(size: 14, weight: .regular))

                    Image("prep")
                    Rectangle()
                        .frame(height: 1)
                        .opacity(0.2)
                        .padding(.bottom, 17)

                    HStack {
                        Text("Estimasi berat")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                        Stepper(digitData: $digitData)
                    }
                    .padding(.bottom, 16)

                    Button(action: {
                        // Code
                    }) {
                        Text("Add item")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 145)
                            .padding(.vertical, 15)
                            .foregroundColor(.white)
                            .background(Color("Ijo"))
                            .cornerRadius(8)
                    }


                }
                .padding(16)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("Botol Plastik")
                            .font(.headline)
                        Spacer()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "xmark")
                        }
                        .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct Stepper: View {
    @Binding var digitData: Float64

    var body: some View {
        HStack(spacing: 15) {
            Button {
                if digitData > 0 {
                    digitData -= 0.5
                }
            } label: {
                Image(systemName: "minus.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color("Ijo"))
            }
            Text("\(digitData, specifier: "%.1f") kg")
                .font(.system(size: 14, weight: .medium))
            Button {
                digitData += 0.5
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .foregroundColor(Color("Ijo"))
            }
        }
        .padding(8)
        .background(Color("Ijo").opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

#Preview {
    WasteCategoryView()
}
