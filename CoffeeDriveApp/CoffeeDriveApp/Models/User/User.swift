//
//  User.swift
//  CoffeeDriveApp
//
//  Created by George on 21.09.21.
//

import Foundation
import Firebase

struct User {
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email ?? ""
    }

    let uid: String
    let email: String
}

