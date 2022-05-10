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

    var id: String?

    @IBOutlet weak var authorName: UILabel! {
        didSet {
            //authorName.text = "Author"
        }
    }
    
    static let identifier = "tableCell"
    
    override func prepareForReuse() {
//        pictureImage = nil
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
        pictureImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            pictureImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pictureImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            pictureImage.rightAnchor.constraint(equalTo: contentView.leftAnchor, constant: 80)
        ])
        
        authorName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorName.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),
            authorName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            authorName.leftAnchor.constraint(equalTo: pictureImage.rightAnchor, constant: 30)
        ])
        
    }
}
