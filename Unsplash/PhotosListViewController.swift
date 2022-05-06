//
//  PhotosListViewController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit
import UnsplashPhotoPicker

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
    
}

class PhotosListViewController: UIViewController {
    
    let photos = ["dog1", "dog2", "dog3", "dog4", "dog5", "dog6", "dog7"]
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=office&client_id=F_0AoAdJhMIu_-pQGHRQCrAJfEda4Qs0_mID-r8podk"
    var results: [Result] = []
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //UnsplashPhotoPickerConfiguration(accessKey: "F_0AoAdJhMIu_-pQGHRQCrAJfEda4Qs0_mID-r8podk", secretKey: "qmD_62BcUL659420M77dSUURFDR4zna6sZ8J0M8pYsA")
        fetchPhotos()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    func fetchPhotos() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! PhotoCell
            detailVC.image = cell.pictureImageView.image
        }
    }
    
    
}

extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
        //return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].urls.full

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        cell.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        cell.layer.borderWidth = 2
        
        cell.configure(with: imageURLString)
        //        cell.authorNameLbl.text = String(indexPath.row)
        
        //let imageName = photos[indexPath.item]
        //let image = UIImage(named: imageName)
        //cell.pictureImageView.image = image
        
        cell.pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.pictureImageView.topAnchor.constraint(equalTo: cell.viewContent.topAnchor, constant: 0),
            cell.pictureImageView.leadingAnchor.constraint(equalTo: cell.viewContent.leadingAnchor, constant: 0),
            cell.pictureImageView.trailingAnchor.constraint(equalTo: cell.viewContent.trailingAnchor, constant: 0),
            cell.pictureImageView.bottomAnchor.constraint(equalTo: cell.viewContent.bottomAnchor, constant: -20)
        ])
        
        
        
        
        return cell
    }
    
}

extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
