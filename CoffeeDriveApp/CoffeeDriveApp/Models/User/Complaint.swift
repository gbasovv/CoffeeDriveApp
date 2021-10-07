//
//  Complaint.swift
//  CoffeeDriveApp
//
//  Created by George on 3.10.21.
//

import Foundation
import Firebase

struct Complaint {
    let title: String
    let text: String
    let userId: String
    let date: String
    let ref: DatabaseReference?

    init(title: String, text: String, userId: String, date: String) {
        self.title = title
        self.text = text
        self.userId = userId
        self.date = date
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let title = snapshotValue[Constants.titleKey] as? String,
              let text = snapshotValue[Constants.textKey] as? String,
              let userId = snapshotValue[Constants.userIdKey] as? String,
        let date = snapshotValue[Constants.dateKey] as? String else { return nil }
        self.title = title
        self.text = text
        self.userId = userId
        self.date = date
        ref = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        [Constants.titleKey: title, Constants.textKey: text, Constants.userIdKey: userId, Constants.dateKey: date]
    }

    private enum Constants {
        static let titleKey = "title"
        static let textKey = "text"
        static let userIdKey = "userId"
        static let dateKey = "date"
    }
}
