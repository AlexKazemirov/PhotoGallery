//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var favoriteItem: UIBarButtonItem!
    @IBOutlet weak var detailPhoto: UIImageView!
    @IBOutlet weak var shareActionImg: UIButton!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailPhoto.image = image
        shareActionImg.layer.cornerRadius = 10
        
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
