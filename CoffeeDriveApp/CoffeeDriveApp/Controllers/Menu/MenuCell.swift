//
//  TableViewCell.swift
//  CoffeeDriveApp
//
//  Created by George on 23.09.21.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var descriptionItem: UILabel!
    
    func configure(with model: CoffeeMenu?) {
        self.imageItem.image = UIImage(named: model?.title ?? "")
        self.nameItem.text = model?.title ?? ""
        self.descriptionItem.text = model?.description ?? ""
    }
    
    func configure(with model: DessertsMenu?) {
        self.imageItem.image = UIImage(named: model?.title ?? "")
        self.nameItem.text = model?.title ?? ""
        self.descriptionItem.text = model?.description ?? ""
    }
    
    func configure(with model: Sandwiches?) {
        self.imageItem.image = UIImage(named: model?.title ?? "")
        self.nameItem.text = model?.title ?? ""
        self.descriptionItem.text = model?.description ?? ""
    }
    
    func configure(with model: Other?) {
        self.imageItem.image = UIImage(named: model?.title ?? "")
        self.nameItem.text = model?.title ?? ""
        self.descriptionItem.text = model?.description ?? ""
    }

}
