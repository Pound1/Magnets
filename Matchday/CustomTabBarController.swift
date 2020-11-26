//
//  CustomTabBarController.swift
//  Matchday
//
//  Created by Lachy Pound on 27/7/19.
//  Copyright © 2019 Lachy Pound. All rights reserved.
//

import UIKit

protocol TabBarControllerDelegate{
    func pushViewController(vc: UIViewController)
}

class CustomTabBarController: UITabBarController, TabBarControllerDelegate {
    
    var first: UIViewController!
    var second: MatchCollectionViewController!
    var third: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let serviceType = MockService() // use this for Mock data
//        let serviceType = Service.shared // use this for URL data
        
        let homeViewController = MatchHistoryView()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.title = "Home"
        homeNavigationController.tabBarItem.image = #imageLiteral(resourceName: "infoIcon")
        
        let homeViewController2 = HomeView()
        let homeNavigationController2 = UINavigationController(rootViewController: homeViewController2)
        homeNavigationController2.tabBarItem.image = UIImage(imageLiteralResourceName: "matchIcon").withRenderingMode(.alwaysTemplate)
        
        let teamListController = TeamListController()
        //        teamListController.service = serviceType
        let teamListNavigationController = UINavigationController(rootViewController: teamListController)
        teamListNavigationController.title = "Players"
        teamListNavigationController.tabBarItem.image = #imageLiteral(resourceName: "playerListIcon")

        
        let settingsController = SettingsViewController(style: .grouped)
        settingsController.navigationItem.title = "Settings"
        let navigationController2 = UINavigationController(rootViewController: settingsController)
        navigationController2.title = "Settings"
        navigationController2.tabBarItem.image = UIImage(imageLiteralResourceName: "historyIcon").withRenderingMode(.alwaysTemplate)

        let matchViewController = MatchCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
//        matchViewController.service = serviceType
        let boardNavigationController = UINavigationController(rootViewController: matchViewController)
        boardNavigationController.title = "Board"
        boardNavigationController.tabBarItem.image = UIImage(imageLiteralResourceName: "boardIcon").withRenderingMode(.alwaysTemplate)
        
        let statsViewController = StatListController()
        let statNavigationController = UINavigationController(rootViewController: statsViewController)
        statNavigationController.title = "Stats"
        statNavigationController.tabBarItem.image = #imageLiteral(resourceName: "statsIcon")
        
        first = teamListNavigationController
        second = matchViewController
        third = statNavigationController
        
        viewControllers = [homeNavigationController, navigationController2, teamListNavigationController, statNavigationController, boardNavigationController, homeNavigationController2]
    }
    
    func pushViewController(vc: UIViewController){
        navigationController?.pushViewController(vc, animated: true)
    }
}


