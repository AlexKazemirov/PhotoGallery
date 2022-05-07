//
//  PhotoCell.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    static let identifier = "photoCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorName: UILabel! {
        didSet {
            authorName.backgroundColor = .white
            authorName.layer.masksToBounds = true
            authorName.layer.cornerRadius = 5
        }
    }
    
    var created_at = ""
    var location: String?
    var likes = 0
    //    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        imageView.frame = contentView.bounds
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        authorName.text = nil
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
                self?.imageView.image = image
            }
        }.resume()
    }
}

