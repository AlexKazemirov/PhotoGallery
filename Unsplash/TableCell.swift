//
//  TableCell.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/8/22.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var pictureImage: UIImageView! {
        didSet {
            //pictureImage.image = UIImage(named: "dog2")
        }
    }

    @IBOutlet weak var id: UILabel! {
        didSet {
            //pictureName.text = "Name"
        }
    }

    @IBOutlet weak var authorName: UILabel! {
        didSet {
            //authorName.text = "Author"
        }
    }
    
    static let identifier = "tableCell"
    
    override func prepareForReuse() {
//        pictureImage = nil
//        pictureName = nil
//        authorName = nil
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.pictureImage.image = image
            }
        }.resume()
    }
    
    func setConstraints() {
        
    }
}
