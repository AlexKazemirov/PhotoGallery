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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        detailPhoto.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            detailPhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            detailPhoto.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            detailPhoto.leftAnchor.constraint(equalTo: view.leftAnchor),
//            detailPhoto.rightAnchor.constraint(equalTo: view.rightAnchor)
//        ])
        
        detailInfo.textColor = .black
        detailInfo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailInfo.topAnchor.constraint(equalTo: detailPhoto.bottomAnchor, constant: 5),
            detailInfo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5)
            //detailInfo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50)
        ])
    }
    
    
    
    @IBAction func favoriteItemAction(_ sender: UIBarButtonItem) {
        
        showAlert(addOrDelete: true)
        
    }
    @IBAction func shareAction(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in            
        }
        present(shareController, animated: true, completion: nil)
    }
    
    func showAlert(addOrDelete: Bool) {
        var msg: String
        
        if addOrDelete {
            msg = "Added"
        } else {
            msg = "Deleted"
        }
        let alert = UIAlertController(title: "Succesfully!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
