//
//  FirstScreenVC.swift
//  LeanScaleCaseStudy
//
//  Created by Yusef Naser on 22/09/2021.
//

import UIKit

class FirstScreenVC : UITabBarController {
    
    let gamesVC = GamesVC()
    let favoriteVC = FavoriteVC()
    
    private let TAG_GAMES = 1 , TAG_FAVORITES = 2
    
    override func viewDidLoad(){
        super.viewDidLoad()

        self.delegate = self
        
        navigationItem.title = SString.games

        
        gamesVC.tabBarItem = UITabBarItem(title: SString.games , image: #imageLiteral(resourceName: "controllers"), tag: TAG_GAMES )
        favoriteVC.tabBarItem = UITabBarItem(title: SString.favorites , image: #imageLiteral(resourceName: "star"), tag: TAG_FAVORITES )
        
       
        viewControllers = [ gamesVC , favoriteVC]
        
        selectedIndex = 0
        
        print("UIDevice.current.model : \(UIDevice.current.model)")
        
    }
    
    
}

extension FirstScreenVC : UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case TAG_GAMES :
            navigationItem.title = SString.games
            break
        case TAG_FAVORITES :
            navigationItem.title = SString.favorites
            break
        default:
            break
        }
    }
    
}
