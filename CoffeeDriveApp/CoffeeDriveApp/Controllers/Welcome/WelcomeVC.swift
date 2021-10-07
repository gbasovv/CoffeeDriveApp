//
//  WelcomeVC.swift
//  CoffeeDriveApp
//
//  Created by George on 1.10.21.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBAction func letsGoTapped(_ sender: UIButton) {
        CheckUser.shared.setIsNotNewUser()
        dismiss(animated: true, completion: nil)
    }
}
