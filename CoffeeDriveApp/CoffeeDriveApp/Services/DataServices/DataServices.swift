//
//  DataServices.swift
//  CoffeeDriveApp
//
//  Created by George on 30.09.21.
//

import Foundation
import Firebase

class DataService {
    private init() { }
    static let shared = DataService()

    let defaults = UserDefaults.standard

    var saveCart: [Cart] {
        get {
            if let data = defaults.value(forKey: "Cart") as? Data {
                return try! PropertyListDecoder().decode([Cart].self, from: data)
            }
            return [Cart]()
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: "Cart")
            }
        }
    }
}
