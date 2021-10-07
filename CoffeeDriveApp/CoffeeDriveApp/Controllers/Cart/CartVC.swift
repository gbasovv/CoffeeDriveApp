//
//  CartVC.swift
//  CoffeeDriveApp
//
//  Created by George on 30.09.21.
//

import UIKit

class CartVC: MainVC {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var orderButton: UIButton!

    private var index = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        index = DataService.shared.saveCart.count - 1
        totalPriceLbl.text = ""
        checkCart()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        totalPriceLbl.text = "\(String(format: "%.2f", (setTotalPrice(index: index)))) $"
    }

    @IBAction func orderTapped(_ sender: Any) {
        FireBaseServices.shared.createOrder(cart: DataService.shared.saveCart, userId: user.uid, date: dateString, index: index, price: setTotalPrice(index: index), ref: ref)
        GlobalFunctions.shared.showAlert(with: Success.orderCreated, vc: self)
        DataService.shared.saveCart.removeAll()
        notifications.scheduleNotification(notificationTitle: NotificationsTitle.order, notificationBody: NotificationsBody.orderCreated)
    }

    @IBAction func clearCart(_ sender: Any) {
        DataService.shared.saveCart.removeAll()
        tableView.reloadData()
        totalPriceLbl.text = ""
        orderButton.isHidden = true
    }

    private func setTotalPrice(index: Int) -> Double {
        var totalPrice = 0.0
        if index < 0 {
            return 0.0
        }
        for i in 0...index {
            totalPrice += DataService.shared.saveCart[i].price
        }
        return totalPrice
    }

    private func checkCart() {
        if DataService.shared.saveCart.isEmpty {
            orderButton.isHidden = true
        } else {
            orderButton.isHidden = false
        }
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.shared.saveCart.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        let current = DataService.shared.saveCart[indexPath.row]
        cell.configure(with: current)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let itemDelete = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] _, _, _ in
            DataService.shared.saveCart.remove(at: indexPath.row)
            let indexPath = [indexPath]
            tableView.deleteRows(at: indexPath, with: .automatic)
            self.index = DataService.shared.saveCart.count - 1
            self.totalPriceLbl.text = "\(self.setTotalPrice(index: self.index)) $"
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [itemDelete])
        return swipeActions
    }
}

