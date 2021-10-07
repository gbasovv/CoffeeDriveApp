//
//  ViewController.swift
//  CoffeeDriveApp
//
//  Created by George on 13.09.21.
//

import UIKit
import Firebase

class MainVC: UIViewController, UITextFieldDelegate {

    var user: User!
    var ref: DatabaseReference!
    let notifications = Notifications()

    @IBOutlet weak var scrollView: UIScrollView!
    
    var passwordStrength: PasswordStrength = .veryWeak

    let date = Date()
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("orders")

        GlobalFunctions.shared.setLogo(navItem: self.navigationItem, named: "LogoNavBar")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       self.startKeyboardObserver()
    }

    func setNavigationBar() {

        self.navigationItem.setHidesBackButton(true, animated: false)

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 13, height: 26))

        if let imgBackArrow = UIImage(named: "BackButton") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)

        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func backToMain() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MainVC.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func setReviewsButton() {
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 13, height: 26))

        let reviewView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let reviewImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 26, height: 26))
        
        if let imgBackArrow = UIImage(named: "BackButton") {
            imageView.image = imgBackArrow
        }
        view.addSubview(imageView)

        if let imgReviewArrow = UIImage(named: "ReviewsIcon") {
            reviewImageView.image = imgReviewArrow
        }
        reviewView.addSubview(reviewImageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        view.addGestureRecognizer(backTap)

        let reviewTap = UITapGestureRecognizer(target: self, action: #selector(goToReviews))
        reviewView.addGestureRecognizer(reviewTap)

        let rightBarButtonItem = UIBarButtonItem(customView: reviewView)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        let leftBarButtonItem = UIBarButtonItem(customView: view)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    @objc func goToReviews() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let reviewsVC = storyBoard.instantiateViewController(withIdentifier: "ReviewsVC") as? ReviewsVC else { return }
        self.show(reviewsVC, sender: nil)
    }
}

