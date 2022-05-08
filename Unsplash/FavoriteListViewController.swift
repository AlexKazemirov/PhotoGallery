//
//  FavoriteListViewController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteList: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(favoriteList.count)
        return favoriteList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier) as! TableCell
        
        cell.authorName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.authorName.topAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -30),
            cell.authorName.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -15),
            cell.authorName.leftAnchor.constraint(equalTo: cell.pictureName.leftAnchor)
        ])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [])
        return swipeConfiguration
    }
}

