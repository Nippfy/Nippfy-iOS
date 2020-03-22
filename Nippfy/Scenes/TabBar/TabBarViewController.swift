//
//  TabBarViewController.swift
//  Nippfy
//
//  Created by Manuel Salvador del Águila on 20/03/2020.
//  Copyright © 2020 Manuel Salvador del Águila. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        let walletController = UINavigationController(rootViewController: WalletViewController())
        walletController.tabBarItem = UITabBarItem(title: "Wallet", image: UIImage(named: "unselected_wallet"), selectedImage: UIImage(named: "selected_wallet"))
        
        let paymentController = UINavigationController(rootViewController: PaymentViewController())
        paymentController.tabBarItem = UITabBarItem(title: "Payment", image: UIImage(named: "unselected_euro"), selectedImage: UIImage(named: "selected_euro"))
        
        let searchController = UINavigationController(rootViewController: SearchViewController())
        searchController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), selectedImage: UIImage(named: "search-2"))
        
        viewControllers = [searchController, walletController, paymentController]
    }
    
}
