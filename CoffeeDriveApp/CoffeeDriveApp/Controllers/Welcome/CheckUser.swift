//
//  CheckUser.swift
//  CoffeeDriveApp
//
//  Created by George on 1.10.21.
//

import Foundation

class CheckUser {
    
    static let shared = CheckUser()
    
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}
