//
//  TabBarController.swift
//  Unsplash
//
//  Created by Алексей Каземиров on 5/10/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet weak var myTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        tabBarItem.title = ""
        
        setTabBarOptions()
    }
    
    func setTabBarOptions() {
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "galleryBar")
        myTabBarItem1.selectedImage = UIImage(named: "galleryBar ")
        myTabBarItem1.title = ""
       // myTabBarItem1.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "starTab")
        myTabBarItem2.selectedImage = UIImage(named: "starTab")
       // myTabBarItem2.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        
    }
}
