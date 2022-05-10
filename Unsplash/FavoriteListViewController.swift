//
//  FavoriteListViewController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit

class FavoriteListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoriteList: [PickedImages] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllItems()
    }
    
    
    
    
}

extension FavoriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(favoriteList.count)
        return favoriteList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = favoriteList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier) as! TableCell
        
        cell.authorName.text = model.authorName
        cell.id.text = model.id
        //cell.pictureImage.image = UIImage(named: model.imageURL ?? "dog1")
        cell.configure(with: model.imageURL ?? "dog1")
        //        let imageName = UIImage(named: String(model.image))
        //        cell.pictureImage = imageName
        
        
        cell.authorName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.authorName.topAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -30),
            cell.authorName.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -15),
            cell.authorName.leftAnchor.constraint(equalTo: cell.id.leftAnchor)
        ])
        
        cell.pictureImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.pictureImage.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            cell.pictureImage.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            cell.pictureImage.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 10),
            cell.pictureImage.rightAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 90)
        ])
        
        cell.id.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.id.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 15),
            cell.id.bottomAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 30),
            cell.id.leftAnchor.constraint(equalTo: cell.pictureImage.rightAnchor, constant: 20)
        ])
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete])
        return swipeConfiguration
    }
    
    func deleteAction (at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            //self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            self.deleteItem(item: self.favoriteList[indexPath.row])
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //self.tableView.reloadData()
            completion(true)
        }
        action.backgroundColor = .systemRed
        action.image = UIImage(systemName: "trash")
        return action
    }
    
    // -MARK: CoreData
    func getAllItems() {
        do {
            favoriteList = try context.fetch(PickedImages.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //error
        }
        
    }
    
    func deleteItem(item: PickedImages) {
        context.delete(item)
        do {
            try context.save()
            getAllItems()
        }
        catch {
            
        }
    }
    
    
}

