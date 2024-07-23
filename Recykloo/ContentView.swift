//
//  ContentView.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 15/07/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PickupFormViewModel()
    @State private var showingLocationPicker = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("SUMMARY")) {
                        List(viewModel.selectedWaste) { waste in
                            HStack {
                                Text(waste.wasteType.nama)
                                    .font(.body)
                                Spacer()
                                Text("\(waste.berat) Kg")
                                    .font(.body)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                    
                    Section(header: Text("PICK UP TIME")) {
                        DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                        Picker("Select Time Slot", selection: $viewModel.selectedTime) {
                            Text("Select Time Slot").foregroundColor(.gray).tag("")
                            ForEach(viewModel.timeSlots, id: \.self) {
                                Text($0).tag($0)
                            }
                        }
                    }
                    
                    Section(header: Text("PICK UP LOCATION")) {
                        NavigationLink(destination: LocationPickerView(selectedLocation: $viewModel.location)) {
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.system(size: 40))
                                    .padding(.trailing, 5)
                                VStack(alignment: .leading) {
                                    if viewModel.location.isEmpty {
                                        Text("No location selected")
                                            .font(.headline)
                                            .foregroundColor(.gray)
                                    } else {
                                        Text(viewModel.location)
                                            .font(.headline)
                                        TextField("Notes", text: $viewModel.locationNotes)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                }
                
                Button(action: viewModel.createSchedule) {
                    Text("Create Schedule")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .navigationTitle("Schedule Pickup")
            .navigationBarItems(leading: Button("Cancel") {
                // Action for Cancel button
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
