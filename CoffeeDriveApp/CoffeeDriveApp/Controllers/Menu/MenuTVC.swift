//
//  TableViewController.swift
//  CoffeeDriveApp
//
//  Created by George on 23.09.21.
//

import UIKit

class MenuTVC: MainTVC {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return menuItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menuItems?.names[section]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return menuItems?.coffee.count ?? 0
        case 1:
            return menuItems?.desserts.count ?? 0
        case 2:
            return menuItems?.sandwiches.count ?? 0
        case 3:
            return menuItems?.other.count ?? 0
        default:
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        switch indexPath.section {
        case 0:
            let coffee = menuItems?.coffee[indexPath.row]
            cell.configure(with: coffee)
            return cell
        case 1:
            let dessert = menuItems?.desserts[indexPath.row]
            cell.configure(with: dessert)
            return cell
        case 2:
            let sandwiches = menuItems?.sandwiches[indexPath.row]
            cell.configure(with: sandwiches)
            return cell
        case 3:
            let other = menuItems?.other[indexPath.row]
            cell.configure(with: other)
            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "ShowDetail", sender: menuItems?.coffee[indexPath.row])
        case 1:
            performSegue(withIdentifier: "ShowDetail", sender: menuItems?.desserts[indexPath.row])
        case 2:
            performSegue(withIdentifier: "ShowDetail", sender: menuItems?.sandwiches[indexPath.row])
        case 3:
            performSegue(withIdentifier: "ShowDetail", sender: menuItems?.other[indexPath.row])
        default:
            performSegue(withIdentifier: "ShowDetail", sender: nil)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailVC,
            let item = sender as? CoffeeMenu {
            vc.coffee = item
        }
        if let vc = segue.destination as? DetailVC,
            let item = sender as? DessertsMenu {
            vc.dessert = item
        }
        if let vc = segue.destination as? DetailVC,
            let item = sender as? Sandwiches {
            vc.sandwiches = item
        }
        if let vc = segue.destination as? DetailVC,
            let item = sender as? Other {
            vc.other = item
        }
    }
}
