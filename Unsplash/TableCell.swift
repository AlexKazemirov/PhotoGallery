//
//  TableCell.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/8/22.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var pictureImage: UIImageView!{
        didSet {
            pictureImage.image = UIImage(named: "dog2")
            
            pictureImage.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pictureImage.topAnchor.constraint(equalTo: contentView.topAnchor),
                pictureImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                pictureImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
                pictureImage.rightAnchor.constraint(equalTo: contentView.leftAnchor, constant: 90)
            ])
        }
    }

    @IBOutlet weak var pictureName: UILabel! {
        didSet {
            pictureName.text = "Name"
            
            pictureName.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pictureName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
                pictureName.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
                pictureName.leftAnchor.constraint(equalTo: pictureImage.rightAnchor, constant: 20)
            ])
        }
    }

    @IBOutlet weak var authorName: UILabel! {
        didSet {
            authorName.text = "Author"
        }
    }
    
    static let identifier = "tableCell"
    
    override func prepareForReuse() {
        pictureImage = nil
        pictureName = nil
        authorName = nil
    }
}
