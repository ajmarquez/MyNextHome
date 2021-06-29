//
//  MainTabBarController.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
        
    let listCoordinator = ListCoordinator()
    let favoritesCoordinator = FavoritesCoordinator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        viewControllers = [listCoordinator.navigationController, favoritesCoordinator.navigationController]
    }
}
