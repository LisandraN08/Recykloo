//
//  Penjemputan.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 17/07/24.
//

import Foundation

struct Penjemputan: Identifiable {
    let id: UUID
    let rombeng: Rombeng
    let order: Order
    
    init(id: UUID = UUID(), rombeng: Rombeng, order: Order) {
        self.id = id
        self.rombeng = rombeng
        self.order = order
    }
}

