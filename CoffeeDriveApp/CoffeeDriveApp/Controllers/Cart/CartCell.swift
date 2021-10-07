//
//  CartCell.swift
//  CoffeeDriveApp
//
//  Created by George on 30.09.21.
//

import UIKit

class CartCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    func configure(with model: Cart) {
        self.titleLbl.text = model.title
        self.countLbl.text = "\(model.count) pc."
        self.priceLbl.text = "\(String(format: "%.2f", (model.price))) $"
    }

}
