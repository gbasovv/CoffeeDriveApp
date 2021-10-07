//
//  SigninVC.swift
//  CoffeeDriveApp
//
//  Created by George on 13.09.21.
//

import UIKit
import Firebase

class SigninVC: MainVC {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if CheckUser.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "WelcomeVC") as! WelcomeVC
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }

    @IBAction func signIn(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                GlobalFunctions.shared.showError(withText: "\(error.localizedDescription)", for: (self?.errorLbl)!)
            } else if let _ = user {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "nextView") as? MenuTVC else { return }
                self?.show(nextVC, sender: nil)
                return
            } else {
                GlobalFunctions.shared.showError(withText: Errors.badUser, for: (self?.errorLbl)!)
            }
        }
    }
}
