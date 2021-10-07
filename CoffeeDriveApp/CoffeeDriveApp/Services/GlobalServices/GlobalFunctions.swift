//
//  GlobalFunctions.swift
//  CoffeeDriveApp
//
//  Created by George on 13.09.21.
//

import UIKit

class GlobalFunctions {
    private init() { }
    static let shared = GlobalFunctions()

    func setLogo(navItem: UINavigationItem, named: String) {
        let logo = UIImage(named: named)
        let imageView = UIImageView(image: logo)
        navItem.titleView = imageView
        navItem.setHidesBackButton(true, animated: false)
    }

    func generateRandom() -> Int {
        let number = Int.random(in: 1...9999)
        return number
    }

    func showError(withText text: String, for label: UILabel) {
        label.text = text
        UIView.animate(withDuration: 5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { label.alpha = 1 }) { _ in
            label.alpha = 0
        }
    }
    
    func checkUser(name: String, phone: String, email: String, password: String, done: UISwitch) -> Bool {
        if name != "", phone != "", email != "", password != "", done.isOn == true {
            return true
        }
        return false
    }
    
    func showAlert(with text: String, vc: UIViewController) {
        let alertController = UIAlertController(title: "Warning!", message: text, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Okay!", style: .cancel) { _ in
            vc.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(ok)
        vc.present(alertController, animated: true)
    }
    
    func compareDates(_ first: String, _ second: String) -> Bool {
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "yyyy-MM-dd"
        let date1 = formatterDate.date(from: first)
        let date2 = formatterDate.date(from: second)
        guard let date1 = date1 else { return false }
        guard let date2 = date2 else { return false }
        let timeInterval1 = date1.timeIntervalSince1970
        let timeInterval2 = date2.timeIntervalSince1970
        let timeInt1 = Int(timeInterval1)
        let timeInt2 = Int(timeInterval2)
        return timeInt1 > timeInt2
    }
}

enum Errors {
    static let emailError = "Wrong Email"
    static let passError = "Wrong Password"
    static let passwordError = "Your password must be a minimum of 8 characters and contain one capital letter, one lowercase letter and one number."
    static let passwordConfirm = "Password mismatch"
    static let incorrentInfo = "Info is incorrect"
    static let badEmailPass = "Wrong Email or Password"
    static let badUser = "No such user"
}

enum Success {
    static let email = "Your email has been successfully changed"
    static let password = "Your password has been successfully changed"
    static let orderCreated = "Your order has been successfully completed! You will receive a notification when the order is accepted for work"
}

enum Titles {
    static let complaints = "Complaints"
    static let reviews = "Reviews"
}

enum NotificationsTitle {
    static let order = "Order"
    static let cart = "Cart"
}

enum NotificationsBody {
    static let orderCreated = "Your order has been accepted for work! To clarify the details, you can call the short number 102. With great love, the team of CoffeeDrive ❤️"
    static let notEmptyCart = "Your cart is not empty! Forgot to place your order? Then go to the app and continue with the checkout. With great love, the team of CoffeeDrive ❤️"
}
