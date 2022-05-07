//
//  PhotosListViewController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/4/22.
//

import UIKit
import UnsplashPhotoPicker



class PhotosListViewController: UIViewController, UISearchBarDelegate, UITabBarDelegate {
    
    //let photosListViewController = PhotosListViewController()
    var collectionView: UICollectionView?
    //@IBOutlet var collectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    
    var results: [Result] = []
    
    let searchBar = UISearchBar()
    let tabBar = UITabBar()
    
    //@IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width/2,
                                 height: view.frame.width/2)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        view.addSubview(collectionView)
        self.collectionView = collectionView
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        tabBar.delegate = self
        view.addSubview(tabBar)
        
        //UnsplashPhotoPickerConfiguration(accessKey: "F_0AoAdJhMIu_-pQGHRQCrAJfEda4Qs0_mID-r8podk", secretKey: "qmD_62BcUL659420M77dSUURFDR4zna6sZ8J0M8pYsA")
        
        fetchPhotos(query: "random")
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.backgroundColor = .systemBackground
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
        collectionView?.frame = CGRect(x: 0, y: 40, width: view.frame.size.width, height: view.frame.size.height-220)
        //tabBar.frame = CGRect(x: 0, y: 500, width: view.frame.width, height: 100)
        //collectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.frame.size.width, height: view.frame.size.height - 55)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            collectionView?.reloadData()
            fetchPhotos(query: text)
        }
    }
    
    
    
    func fetchPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=30&query=\(query)&client_id=F_0AoAdJhMIu_-pQGHRQCrAJfEda4Qs0_mID-r8podk"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.collectionView?.reloadData()
                }
            }
            catch {
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
            let detailVC = segue.destination as! DetailViewController
            let cell = sender as! PhotoCell
            detailVC.image = cell.imageView.image
        }
    }
    
    
}

extension PhotosListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
        //return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].urls.small
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        //cell.inputViewController?.segueForUnwinding(to: detailViewController, from: photosListViewController, identifier: "showPhoto")
        
        
        
        //        cell.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        //        cell.layer.borderWidth = 2
        
        cell.configure(with: imageURLString)
        //        cell.authorNameLbl.text = String(indexPath.row)
        
        //let imageName = photos[indexPath.item]
        //let image = UIImage(named: imageName)
        //cell.pictureImageView.image = image
        
        //        cell.imageView.translatesAutoresizingMaskIntoConstraints = false
        //        NSLayoutConstraint.activate([
        //            cell.imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
        //            cell.imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 0),
        //            cell.imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 0),
        //            cell.imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0)
        //        ])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        guard let image = cell.imageView.image else {
            return
        }
        let detailVC = DetailViewController()
        detailVC.image = cell.imageView.image
        prepare(for: UIStoryboardSegue(identifier: "showPhoto", source: PhotosListViewController(), destination: DetailViewController()), sender: nil)
        
        
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
