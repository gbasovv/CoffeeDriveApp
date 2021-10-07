//
//  ViewController2.swift
//  CoffeeDriveApp
//
//  Created by George on 24.09.21.
//

import UIKit
import Firebase

class DetailVC: MainVC {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var nameItem: UILabel!
    @IBOutlet weak var priceItem: UILabel!
    @IBOutlet weak var sizeSelection: UIPickerView!
    @IBOutlet weak var descriptionItem: UILabel!
    @IBOutlet weak var commentsText: UITextView!
    @IBOutlet weak var countStepper: UIStepper!

    var coffee: CoffeeMenu?
    var dessert: DessertsMenu?
    var sandwiches: Sandwiches?
    var other: Other?
    private var count = 1

    private var coffeePrice = 1.0
    private var otherPrice = 1.0

    private var coffeeSize = 1
    private var otherSize = 1

    private let stepperCount: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        sizeSelection.dataSource = self
        sizeSelection.delegate = self
        self.sizeSelection.selectRow(1, inComponent: 0, animated: false)

        configure(with: coffee, sizeSelected: 1)
        configure(with: sandwiches)
        configure(with: dessert)
        configure(with: other, sizeSelected: 1)

        stepperCount.textColor = .white
        stepperCount.font = UIFont(name: "Montserrat", size: 15)
        stepperCount.text = "\(count)"
        countStepper.addSubview(stepperCount)
        stepperCount.frame = CGRect(x: countStepper.frame.size.width / 2 - 50, y: countStepper.frame.size.height / 2 - 25, width: 100, height: 50)
    }

    private func configure(with coffee: CoffeeMenu?, sizeSelected: Int) {
        guard let coffee = coffee else { return }
        imageItem.image = UIImage(named: coffee.title)
        nameItem.text = coffee.title
        coffeePrice = coffee.price[sizeSelected]
        priceItem.text = "\(coffeePrice)$"
        descriptionItem.text = coffee.description

        countStepper.stepValue = coffee.price[sizeSelected]
        countStepper.value = 0.0

        coffeeSize = sizeSelected
    }

    private func configure(with sandwiches: Sandwiches?) {
        guard let sandwiches = sandwiches else { return }
        imageItem.image = UIImage(named: sandwiches.title)
        nameItem.text = sandwiches.title
        priceItem.text = "\(sandwiches.price)$"
        descriptionItem.text = sandwiches.description

        countStepper.stepValue = sandwiches.price
        countStepper.value = 0.0

        sizeSelection.isHidden = true
    }

    private func configure(with desert: DessertsMenu?) {
        guard let desert = desert else { return }
        imageItem.image = UIImage(named: desert.title)
        nameItem.text = desert.title
        priceItem.text = "\(desert.price)$"
        descriptionItem.text = desert.description

        countStepper.stepValue = desert.price
        countStepper.value = desert.price

        sizeSelection.isHidden = true
    }

    private func configure(with other: Other?, sizeSelected: Int) {
        guard let other = other else { return }
        imageItem.image = UIImage(named: other.title)
        nameItem.text = other.title
        otherPrice = other.price[sizeSelected]
        priceItem.text = "\(otherPrice)$"
        descriptionItem.text = other.description

        countStepper.stepValue = other.price[sizeSelected]
        countStepper.value = 0.0

        otherSize = sizeSelected
    }

    @IBAction func countChanged(_ sender: UIStepper) {

        if coffee != nil {
            let price = String(format: "%.2f", (coffeePrice + sender.value))
            priceItem.text = price + "$"
            count = Int(sender.value / coffeePrice) + 1
            stepperCount.text = "\(count)"
        }

        if let dessert = dessert {
            let price = String(format: "%.2f", (dessert.price + sender.value))
            priceItem.text = price + "$"
            count = Int(sender.value / dessert.price) + 1
            stepperCount.text = "\(count)"
        }

        if let sandwiches = sandwiches {
            let price = String(format: "%.2f", (sandwiches.price + sender.value))
            priceItem.text = price + "$"
            count = Int(sender.value / sandwiches.price) + 1
            stepperCount.text = "\(count)"
        }

        if other != nil {
            let price = String(format: "%.2f", (otherPrice + sender.value))
            priceItem.text = price + "$"
            count = Int(sender.value / otherPrice) + 1
            stepperCount.text = "\(count)"
        }
    }

    @IBAction func orderTapped(_ sender: Any) {
        if let coffee = coffee {
            let order = Cart(title: coffee.title, price: (coffeePrice * Double(count)), count: count, size: coffee.size[coffeeSize], comment: commentsText.text)
            DataService.shared.saveCart.append(order)
        }
        if let dessert = dessert {
            let order = Cart(title: dessert.title, price: (dessert.price * Double(count)), count: count, size: dessert.size, comment: commentsText.text)
            DataService.shared.saveCart.append(order)
        }
        if let sandwiches = sandwiches {
            let order = Cart(title: sandwiches.title, price: (sandwiches.price * Double(count)), count: count, size: sandwiches.size, comment: commentsText.text)
            DataService.shared.saveCart.append(order)
        }
        if let other = other {
            let order = Cart(title: other.title, price: (otherPrice * Double(count)), count: count, size: other.size[otherSize], comment: commentsText.text)
            DataService.shared.saveCart.append(order)
        }
        self.navigationController?.popViewController(animated: true)
    }

}

extension DetailVC: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if coffee != nil {
            return coffee?.size.count ?? 0
        } else if other != nil {
            return other?.size.count ?? 0
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if coffee != nil {
            return coffee?.size[row]
        } else if other != nil {
            return other?.size[row]
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if let coffee = coffee {
            let title = coffee.size[row]
            let myTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Montserrat", size: 15)!])
            return myTitle
        }
        if let other = other {
            let title = other.size[row]
            let myTitle = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Montserrat", size: 15)!])
            return myTitle
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        count = 1
        stepperCount.text = "\(count)"
        switch row {
        case 0:
            configure(with: coffee, sizeSelected: 0)
            configure(with: other, sizeSelected: 0)
        case 1:
            configure(with: coffee, sizeSelected: 1)
            configure(with: other, sizeSelected: 1)
        case 2:
            configure(with: coffee, sizeSelected: 2)
            configure(with: other, sizeSelected: 2)
        default:
            configure(with: coffee, sizeSelected: 1)
            configure(with: other, sizeSelected: 1)
        }
    }

}
