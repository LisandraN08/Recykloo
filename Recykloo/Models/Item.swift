//
//  Item.swift
//  Recykloo
//
//  Created by Lisandra Nicoline on 15/07/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
