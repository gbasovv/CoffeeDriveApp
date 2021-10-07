//
//  LoginVC.swift
//  CoffeeDriveApp
//
//  Created by George on 13.09.21.
//

import UIKit
import Firebase

class LoginVC: MainVC {

    private var reference: DatabaseReference!

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var doneSwitch: UISwitch!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet var verifPassView: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        reference = Database.database().reference(withPath: "users")
    }

    @IBAction func logIn(_ sender: UIButton) {
        guard let email = emailTF.text, let password = passwordTF.text, let name = nameTF.text, let phone = phoneTF.text else { return }
        if GlobalFunctions.shared.checkUser(name: name, phone: phone, email: email, password: password, done: doneSwitch) == false {
            GlobalFunctions.shared.showError(withText: Errors.incorrentInfo, for: errorLbl)
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] user, error in
            if let error = error {
                GlobalFunctions.shared.showError(withText: "Registration was incorrect\n\(error.localizedDescription)", for: (self?.errorLbl)!)
            } else {
                guard let user = user else { return }
                let userRef = self?.reference.child(user.user.uid)
                userRef?.setValue(["email": user.user.email, "name": name, "phone": phone])

                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let nextVC = storyBoard.instantiateViewController(withIdentifier: "nextView") as? MenuTVC else { return }
                self?.show(nextVC, sender: nil)
            }
        }
    }

    @IBAction func passTFChanged(_ sender: UITextField) {
        guard let pass = sender.text else { return }
        passwordStrength = VerificationService.isValidPassword(pass: pass)
        if !(passwordStrength == .veryWeak) {
            GlobalFunctions.shared.showError(withText: Errors.passwordError, for: errorLbl)
        }
        verifPassView.enumerated().forEach { (index, view) in
            if (index <= (passwordStrength.rawValue - 1)) {
                view.alpha = 1
            } else {
                view.alpha = 0.2
            }
        }
    }

    @IBAction func signIn(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

