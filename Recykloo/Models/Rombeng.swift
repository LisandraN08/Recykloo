//
//  Rombeng.swift
//  Recykloo
//
//  Created by Eldenabih Tavirazin Lutvie on 17/07/24.
//

import Foundation

struct Rombeng: Identifiable {
    let id: UUID
    let nama: String
    let wilayah: String
    
    init(id: UUID = UUID(), nama: String, wilayah: String) {
        self.id = id
        self.nama = nama
        self.wilayah = wilayah
    }
}

