//
//  Reviews.swift
//  CoffeeDriveApp
//
//  Created by George on 4.10.21.
//

import Foundation

struct Results: Decodable {
    let query: Query
    let reviews: [Reviews]
}

struct Query: Decodable {
    let apikey: String?
    let url: String?
    let amount: String?
}

struct Reviews: Decodable {
    let platform: String?
    let rating: Int?
    let user_name: String?
    let text: String?
    let title: String?
    let timestamp: String?
    let platform_specific: [PlatformSpecific]
}

struct PlatformSpecific: Decodable {
    
}
