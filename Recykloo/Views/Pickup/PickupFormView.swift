//
//  PickupFormView.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 18/07/24.
//

import SwiftUI

struct PickupFormView: View {
    @StateObject private var viewModel = PickupFormViewModel()
    @State private var showingLocationPicker = false
    @State private var selectedLocation: String = ""
    
    var selectedWastes: [Waste]
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("SUMMARY")) {
                    List(selectedWastes) { waste in
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
                    NavigationLink(destination: MapView(selectedLocation: $selectedLocation)) {
                        HStack {
                            Image(systemName: "mappin.circle.fill")
                                .foregroundColor(.green)
                                .font(.system(size: 40))
                                .padding(.trailing, 5)
                            VStack(alignment: .leading) {
                                if selectedLocation.isEmpty {
                                    Text("No location selected")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                } else {
                                    Text(selectedLocation)
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
            
            Button(action: {
                viewModel.selectedWaste = selectedWastes
                viewModel.location = selectedLocation
                viewModel.createSchedule()
            }) {
                Text("Create Schedule")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Ijo"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationTitle("Schedule Pickup")
    }
    
}

struct PickupFormView_Previews: PreviewProvider {
    static var previews: some View {
        PickupFormView(selectedWastes: [])
    }
}
