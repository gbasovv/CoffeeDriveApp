//
//  OrderHistoryVC.swift
//  CoffeeDriveApp
//
//  Created by George on 3.10.21.
//

import UIKit
import Firebase

class ReviewsVC: MainVC {

    let dataFetcherService = DataFetcherService()
    var reviews = [Reviews]()
    var complaints = [Complaint]()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()

        dataFetcherService.fetchReviews { result in
            guard let result = result else { return }
            self.reviews = result.reviews
            self.reviews.sort { (review1: Reviews, review2: Reviews) -> Bool in
                return GlobalFunctions.shared.compareDates(review1.timestamp ?? "", review2.timestamp ?? "")
            }
            self.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("complaints")
        loadComplaints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.removeAllObservers()
    }

    private func loadComplaints() {
        ref.observe(.value) { [weak self] snapshot in
            var complaints = [Complaint]()
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot, let complaint = Complaint(snapshot: snapshot) else { continue }
                complaints.append(complaint)
            }
            self?.complaints = complaints
            self?.complaints.sort { (complaint1: Complaint, complaint2: Complaint) -> Bool in
                return GlobalFunctions.shared.compareDates(complaint1.date, complaint2.date)
            }
            self?.tableView.reloadData()
        }
    }
}

extension ReviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if complaints.isEmpty {
            return 1
        }
        return 2
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if complaints.isEmpty {
            return Titles.reviews
        }
        switch section {
        case 0:
            return Titles.complaints
        case 1:
            return Titles.reviews
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .gray
        header.textLabel?.font = UIFont(name: "Montserrat", size: 18)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return complaints.count
        case 1:
            return reviews.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
        switch indexPath.section {
        case 0:
            let complaint = complaints[indexPath.row]
            cell.configure(with: complaint)
            return cell
        case 1:
            let review = reviews[indexPath.row]
            cell.configure(with: review)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
