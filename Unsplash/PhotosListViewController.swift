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
    //var collectionView: UICollectionView?
    @IBOutlet var collectionView: UICollectionView!
    
    let itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    
    var results: [Result] = []
    var favoriteList: [String] = []
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
        

        lazy var searchBar : UISearchBar = {
            let s = UISearchBar()
                s.placeholder = "Search Timeline"
                s.delegate = self
                s.tintColor = .white
                s.barStyle = .default
                s.sizeToFit()
            return s
        }()
        
        
        fetchPhotos(query: "random")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(favoriteList.count)
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
        //collectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 55, width: view.frame.size.width, height: view.frame.size.height - 55)
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            collectionView.reloadData()
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
                    self?.collectionView.reloadData()
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
            detailVC.image = cell.imageView?.image
            detailVC.detailText = """
                                            Name: \(cell.authorName.text ?? "No name")
                                            Location: \(cell.location ?? "No location")
                                            Likes: \(cell.likes)
                                            Created at: \(cell.created_at.split(separator: "T")[0])
                                        """
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
        let name = results[indexPath.row].user.name
        let created_at = results[indexPath.row].created_at
        let location = results[indexPath.row].user.location
        let likes = results[indexPath.row].likes
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        
        cell.created_at = created_at
        cell.location = location
        cell.likes = likes
        cell.configure(with: imageURLString)
        cell.authorName.text = name
        
        cell.imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 0),
            cell.imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 0),
            cell.imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: 0),
            cell.imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0)
        ])
        
        cell.authorName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cell.authorName.topAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -20),
            cell.authorName.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: 0)
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
                header.addSubview(searchBar)
                searchBar.translatesAutoresizingMaskIntoConstraints = false
                searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
                searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
                searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
                searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
            return header
    }
}
