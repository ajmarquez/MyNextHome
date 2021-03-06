//
//  ListCoordinator.swift
//  MyNextHome
//
//  Created by Abelardo Marquez on 25.06.21.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        
        print("ListCoordinator")
        let vc = RealStateViewController(with: RealStateViewModel(with: HomegateAPI()))
        vc.view.backgroundColor = .red
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        navigationController.viewControllers = [vc]
    }
    
    func start() {}
    
}
