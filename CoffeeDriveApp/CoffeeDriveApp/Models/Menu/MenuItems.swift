//
//  MenuItems.swift
//  CoffeeDriveApp
//
//  Created by George on 20.09.21.
//

import UIKit

struct MenuItems: Decodable {
    var coffee: [CoffeeMenu]
    var desserts: [DessertsMenu]
    var sandwiches: [Sandwiches]
    var other: [Other]
    var count: Int
    var names: [String]
}

struct CoffeeMenu: Decodable {
    var title: String
    var description: String
    var price: [Double]
    var ingredients: [String]
    var size: [String]
}

struct DessertsMenu: Decodable {
    var title: String
    var description: String
    var price: Double
    var size: String
}

struct Sandwiches: Decodable {
    var title: String
    var description: String
    var price: Double
    var size: String
}

struct Other: Decodable {
    var title: String
    var description: String
    var price: [Double]
    var size: [String]
}


