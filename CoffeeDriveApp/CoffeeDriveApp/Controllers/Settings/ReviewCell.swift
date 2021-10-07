//
//  ReviewCell.swift
//  CoffeeDriveApp
//
//  Created by George on 4.10.21.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    
    func configure(with model: Reviews) {
        titleLbl.text = model.title
        textLbl.text = model.text
        dateLbl.text = model.timestamp
        statusLbl.text = "Published"
        statusLbl.textColor = .green
    }
    
    func configure(with model: Complaint) {
        titleLbl.text = model.title
        textLbl.text = model.text
        dateLbl.text = model.date
    }
}
