//
//  AccountVC.swift
//  CoffeeDriveApp
//
//  Created by George on 29.09.21.
//

import UIKit
import Firebase

class AccountVC: MainVC {

    @IBOutlet weak var oldEmailTF: UITextField!
    @IBOutlet weak var newEmailTF: UITextField!
    @IBOutlet weak var errorEmail: UILabel!

    @IBOutlet weak var newPassTF: UITextField!
    @IBOutlet weak var confNewPassTF: UITextField!
    @IBOutlet weak var errorPass: UILabel!

    @IBOutlet var verifPassView: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setReviewsButton()
    }
    
    @IBAction func changeEmail(_ sender: Any) {
        guard let oldEmail = oldEmailTF.text else { return }
        if user.email != oldEmail {
            GlobalFunctions.shared.showError(withText: Errors.emailError, for: errorEmail)
            return
        }
        guard let newEmail = newEmailTF.text else {
            GlobalFunctions.shared.showError(withText: Errors.emailError, for: errorEmail)
            return
        }
        Auth.auth().currentUser?.updateEmail(to: newEmail) { [unowned self] error in
            if let error = error {
                GlobalFunctions.shared.showError(withText: "\(error.localizedDescription)", for: self.errorEmail)
            } else {
                GlobalFunctions.shared.showAlert(with: Success.email, vc: self)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func passTFChanged(_ sender: UITextField) {
        guard let pass = sender.text else { return }
        passwordStrength = VerificationService.isValidPassword(pass: pass)
        if !(passwordStrength == .veryWeak) {
            GlobalFunctions.shared.showError(withText: Errors.passwordError, for: errorPass)
        }
        verifPassView.enumerated().forEach { (index, view) in
            if (index <= (passwordStrength.rawValue - 1)) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }

    @IBAction func changePassword(_ sender: Any) {
        guard let newPass = newPassTF.text, let confNewPass = confNewPassTF.text else { return }
        if newPass != confNewPass {
            GlobalFunctions.shared.showError(withText: Errors.passwordConfirm, for: errorPass)
            return
        }
        Auth.auth().currentUser?.updatePassword(to: newPass) { [unowned self] error in
            if let error = error {
                GlobalFunctions.shared.showError(withText: "\(error.localizedDescription)", for: self.errorPass)
            } else {
                GlobalFunctions.shared.showAlert(with: Success.password, vc: self)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    @IBAction func signOutTapped(_ sender: Any) {
        DataService.shared.saveCart.removeAll()
        FireBaseServices.shared.signOut()
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func complain(_ sender: Any) {
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("complaints")
        FireBaseServices.shared.createCompaint(vc: self, ref: ref, user: user, date: dateString)
    }

    @IBAction func deleteAccount(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        currentUser?.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.ref = Database.database().reference(withPath: "users").child(self.user.uid)
                self.ref.setValue(nil)
                DataService.shared.saveCart.removeAll()
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}
