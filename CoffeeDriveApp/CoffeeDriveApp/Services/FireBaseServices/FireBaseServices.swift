//
//  FireBaseServices.swift
//  CoffeeDriveApp
//
//  Created by George on 25.09.21.
//

import Firebase
import UIKit

class FireBaseServices {
    private init() { }
    static let shared = FireBaseServices()

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }

    func createOrder(cart: [Cart], userId: String, date: String, index: Int, price: Double, ref: DatabaseReference) {
        let orderNum = GlobalFunctions.shared.generateRandom()
        let orderRef = ref.child("№" + String(orderNum))
        orderRef.setValue(["userId": userId, "date": date, "total": price])
        
        for i in 0...index {
            let name = cart[i].title
            let detailOrderRef = orderRef.child(name)
            let value = ["title": cart[i].title, "price": cart[i].price, "count": cart[i].count, "size": cart[i].size, "comment": cart[i].comment as Any]
            detailOrderRef.setValue(value)
        }
    }
    
    func createCompaint(vc: UIViewController, ref: DatabaseReference, user: User, date: String) {
        let alertController = UIAlertController(title: "Complaint", message: "Add new complaint", preferredStyle: .alert)
        alertController.addTextField()
        alertController.addTextField()
        
        guard let titleTF = alertController.textFields?[0],
              let textTF = alertController.textFields?[1] else { return }
        
        titleTF.placeholder = "What did you order?"
        textTF.placeholder = "What was wrong?"
        
        let complain = UIAlertAction(title: "Complain", style: .default) { _ in
            
            guard let title = titleTF.text,
                  let text = textTF.text else { return }
            
            let complaint = Complaint(title: title, text: text, userId: user.uid, date: date)
            
            let compRef = ref.child(complaint.title.lowercased())
            
            compRef.setValue(complaint.convertToDictionary())
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(complain)
        alertController.addAction(cancel)
        vc.present(alertController, animated: true)
    }
}
