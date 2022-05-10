//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteItem: UIBarButtonItem!
    @IBOutlet weak var detailPhoto: UIImageView! {
        didSet {
            detailPhoto.image = image
        }
    }
    @IBOutlet weak var shareActionImg: UIButton! {
        didSet {
            shareActionImg.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var detailInfo: UILabel! {
        didSet {
            detailInfo.text = detailText
            
            detailInfo.numberOfLines = 0
            detailInfo.textAlignment = .left
            detailInfo.layer.masksToBounds = true
            detailInfo.layer.cornerRadius = 5
            detailInfo.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            detailInfo.layer.borderWidth = 0.5
            detailInfo.backgroundColor = .white
        }
    }
    
    var image: UIImage?
    var detailText: String?
    
    var id: String?
    var imageURL: String?
    var authorName: String?
    
    var favoriteList: [PickedImages] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailInfo.textColor = .black
        
        detailInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailInfo.topAnchor.constraint(equalTo: detailPhoto.bottomAnchor, constant: 5),
            detailInfo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
            //detailInfo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = self.tabBarController!.viewControllers![0] as! UINavigationController
        let vc = navController.topViewController as! PhotosListViewController
        
        vc.favoriteList[0] = "DOG"//.insert(image!, at: vc.favoriteList.endIndex)
        print(vc.favoriteList.count)
//        let controllers = self.tabBarController?.viewControllers
//        let favoriteVC = controllers?[1] as! FavoriteListViewController
//
//        favoriteVC.favoriteList.append(image!)
    }
    
    
    @IBAction func favoriteItemAction(_ sender: UIBarButtonItem) {
        
        self.createItem(id: id ?? "Id", authorName: authorName ?? "Author name", image: imageURL ?? "dog1")
//        favoriteList.append("dog")
//        print("Massive: \(favoriteList)")
        showAlert(addOrDelete: true)
        
    }
    @IBAction func shareAction(_ sender: Any) {
        
        
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in            
        }
        present(shareController, animated: true, completion: nil)
    }
    
    func showAlert(addOrDelete: Bool) {
        
        let alert = UIAlertController(title: "Done", message: "Added!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    // -MARK: CoreData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func createItem(id: String, authorName: String, image: String) {
        let newItem = PickedImages(context: context)
        newItem.id = id
        newItem.authorName = authorName
        newItem.imageURL = image
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    func deleteItem(item: PickedImages) {
        context.delete(item)
        do {
            try context.save()
        }
        catch {
            
        }
    }

}
