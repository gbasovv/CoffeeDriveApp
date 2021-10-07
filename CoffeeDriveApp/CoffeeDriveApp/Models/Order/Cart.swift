//
//  Cart.swift
//  CoffeeDriveApp
//
//  Created by George on 30.09.21.
//

import Foundation

struct Cart: Codable {
    let title: String
    let price: Double
    let count: Int
    let size: String
    let comment: String?
    
    init(title: String, price: Double, count: Int, size: String, comment: String?) {
        self.title = title
        self.price = price
        self.count = count
        self.size = size
        self.comment = comment
    }
}
