//
//  Waste.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 17/07/24.
//

import Foundation

struct Waste: Identifiable {
    let id: UUID
    let wasteType: WasteType
    let berat: Int
    
    init(id: UUID = UUID(), wasteType: WasteType, berat: Int) {
        self.id = id
        self.wasteType = wasteType
        self.berat = berat
    }
}
