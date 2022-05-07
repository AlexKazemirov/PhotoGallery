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
    //    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(imageView ?? <#default value#>)
//    }
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

