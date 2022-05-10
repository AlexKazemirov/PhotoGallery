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
        
        view.backgroundColor = .white
        
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
        cell.id = model.id
        //cell.pictureImage.image = UIImage(named: model.imageURL ?? "dog1")
        cell.configure(with: model.imageURL!)
        //        let imageName = UIImage(named: String(model.image))
        //        cell.pictureImage = imageName
        
        cell.setConstraints()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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

