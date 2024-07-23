//
//  ScheduleViewModel.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 18/07/24.
//

import Foundation
import SwiftUI

class PickupFormViewModel: ObservableObject {
    @Published var selectedWaste: [Waste] = [
        Waste(wasteType: WasteType(nama: "Botol Plastik", gambar: "plastik.png", poinPerKilo: 10, category: "Plastik"), berat: 5),
        Waste(wasteType: WasteType(nama: "Meja Plastik", gambar: "kertas.png", poinPerKilo: 8, category: "Plastik"), berat: 3),
        Waste(wasteType: WasteType(nama: "Botol Kaca", gambar: "kaca.png", poinPerKilo: 15, category: "Kaca"), berat: 7)
    ]
    
    @Published var selectedDate: Date = Date()
    @Published var selectedTime: String = ""
    @Published var location: String = ""
    @Published var locationNotes: String = ""
    @Published var showingAlert = false
    @Published var alertMessage = ""
    
    let timeSlots = ["6:00-9:00", "12:00-15:00", "18:00-21:00"]
    
    func createOrder() -> Order? {
        guard !selectedTime.isEmpty, !location.isEmpty else {
            alertMessage = "Please fill in all fields correctly"
            showingAlert = true
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: selectedDate)
        
        var totalPoin = 0
        let wasteDetails = selectedWaste.enumerated().map { (index, waste) -> String in
            totalPoin += waste.berat * waste.wasteType.poinPerKilo
            return """
            \(index + 1). *Waste Type: \(waste.wasteType.nama)*
            - Weight: \(waste.berat) kg
            - Points per Kilo: \(waste.wasteType.poinPerKilo)
            - Category: \(waste.wasteType.category)
            """
        }.joined(separator: "\n")
        
        let rombeng = Rombeng(nama: "John Doe", wilayah: "Surabaya")
        
        let order = Order(
            wastes: selectedWaste,
            intervalJam: selectedTime,
            hari: formattedDate,
            lokasi: location,
            status: "Pending",
            rombeng: rombeng,
            poin: totalPoin,
            keteranganLokasi: locationNotes
        )
        
        return order
    }
    
    func createSchedule() {
        guard let order = createOrder() else { return }
        
        let wasteDetails = order.wastes.enumerated().map { (index, waste) -> String in
            return """
            \(index + 1). *Waste Type: \(waste.wasteType.nama)*
            - Weight: \(waste.berat) kg
            - Points per Kilo: \(waste.wasteType.poinPerKilo)
            - Category: \(waste.wasteType.category)
            """
        }.joined(separator: "\n")
        
        let message = """
        *New Schedule:*
        Waste list:
        \(wasteDetails)
        
        Details:
        - Date: \(order.hari)
        - Time Slot: \(order.intervalJam)
        - Location: \(order.lokasi), notes: \(order.keteranganLokasi)
        - Total Points: \(order.poin)
        """
        
        sendMessageToWhatsApp(message: message)
    }
    
    func sendMessageToWhatsApp(message: String) {
        let phoneNumber = "6281249395866"
        let urlString = "https://api.whatsapp.com/send?phone=\(phoneNumber)&text=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                alertMessage = "WhatsApp is not installed on this device."
                showingAlert = true
            }
        }
    }
}

