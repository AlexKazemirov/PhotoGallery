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
            shareActionImg.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
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
        
        view.backgroundColor = .white

        detailInfo.textColor = .black
        
        setConstraints()
    }
    
    @IBAction func favoriteItemAction(_ sender: UIBarButtonItem) {
        
        getAllItems()
        var k = 0
        for i in 0..<favoriteList.count {
            id == favoriteList[i].id ? (k += 1) : (k += 0)
        }
        
        if k == 0 {
            self.createItem(id: id ?? "Id", authorName: authorName ?? "Author name", image: imageURL ?? "galleryTab")
            showAlert(isOrNot: false)
        } else {
            showAlert(isOrNot: true)
        }
        
        
        
        
    }
    @IBAction func shareAction(_ sender: Any) {
        
        
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in
        }
        present(shareController, animated: true, completion: nil)
    }
    
    func showAlert(isOrNot: Bool) {
        
        if isOrNot == false {
            let alert = UIAlertController(title: "✅", message: "Picture added to favorites successfully!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "⚠️", message: "This picture is already in favorites!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        }
    }
    
    func setConstraints() {
        
        detailInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailInfo.topAnchor.constraint(equalTo: detailPhoto.bottomAnchor, constant: 5),
            detailInfo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
        ])
        
        shareActionImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareActionImg.topAnchor.constraint(equalTo: detailPhoto.bottomAnchor, constant: -10),
            shareActionImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            shareActionImg.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            shareActionImg.bottomAnchor.constraint(equalTo: detailPhoto.bottomAnchor, constant: 25)
        ])
        
    }
    
    // -MARK: CoreData
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItems() {
        do {
            favoriteList = try context.fetch(PickedImages.fetchRequest())
        }
        catch {
            //error
        }
        
    }
    
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
    
}
