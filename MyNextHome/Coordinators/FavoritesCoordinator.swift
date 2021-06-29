//
//  FavoriteCoordinator.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit

class FavoritesCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        
        let vc = FavoritesViewController(with: RealStateViewModel(with: HomegateAPI()))
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        navigationController.viewControllers = [vc]
    }
    
    func start() {

    }
    
}
