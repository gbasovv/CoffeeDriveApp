//
//  MainTVC.swift
//  CoffeeDriveApp
//
//  Created by George on 1.10.21.
//

import UIKit

class MainTVC: UITableViewController {
    
    let dataFetcherService = DataFetcherService()
    var menuItems: MenuItems?

    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalFunctions.shared.setLogo(navItem: self.navigationItem, named: "LogoNavBarGreen")
        getMenuItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    func getMenuItems() {
        dataFetcherService.fetchLocalMenu { items in
            guard let items = items else { return }
            self.menuItems = items
            self.tableView.reloadData()
        }
    }

    func setNavigationBar() {

        self.navigationItem.setHidesBackButton(true, animated: false)

        let viewSettings = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageViewSettings = UIImageView(frame: CGRect(x: 10, y: 10, width: 28, height: 28))

        let viewCart = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let imageViewCart = UIImageView(frame: CGRect(x: 10, y: 10, width: 33, height: 28))

        if let imgSetArrow = UIImage(named: "Settings") {
            imageViewSettings.image = imgSetArrow
        }
        viewSettings.addSubview(imageViewSettings)

        if DataService.shared.saveCart.isEmpty {
            if let imgCartArrow = UIImage(named: "Cart") {
                imageViewCart.image = imgCartArrow
            }
            viewCart.addSubview(imageViewCart)
        } else {
            if let imgCartArrow = UIImage(named: "CartWithOrder") {
                imageViewCart.image = imgCartArrow
            }
            viewCart.addSubview(imageViewCart)
        }

        let settingsTap = UITapGestureRecognizer(target: self, action: #selector(goToSettings))
        viewSettings.addGestureRecognizer(settingsTap)

        let cartTap = UITapGestureRecognizer(target: self, action: #selector(goToCart))
        viewCart.addGestureRecognizer(cartTap)

        let rightBarButtonItem = UIBarButtonItem(customView: viewSettings)
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        let leftBarButtonItem = UIBarButtonItem(customView: viewCart)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func goToSettings() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let profileVC = storyBoard.instantiateViewController(withIdentifier: "SettingsVC") as? AccountVC else { return }
        self.show(profileVC, sender: nil)
    }

    @objc func goToCart() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let cartVC = storyBoard.instantiateViewController(withIdentifier: "CartVC") as? CartVC else { return }
        self.show(cartVC, sender: nil)
    }
    
}
