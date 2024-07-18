//
//  Order.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 17/07/24.
//

import Foundation

struct Order: Identifiable {
    let id: UUID
    let waste: Waste
    let intervalJam: String
    let hari: String
    let lokasi: String
    let keteranganLokasi: String
    let status: String
    let rombeng: Rombeng
    let poin: Int
    
    init(id: UUID = UUID(), waste: Waste, intervalJam: String, hari: String, lokasi: String, status: String, rombeng: Rombeng, poin: Int, keteranganLokasi: String) {
        self.id = id
        self.waste = waste
        self.intervalJam = intervalJam
        self.hari = hari
        self.lokasi = lokasi
        self.status = status
        self.rombeng = rombeng
        self.poin = poin
        self.keteranganLokasi = keteranganLokasi
    }
}

