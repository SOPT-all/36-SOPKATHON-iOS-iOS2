//
//  MainTabBarController.swift
//  SOPKATHON36
//
//  Created by 김승원 on 5/17/25.
//

import UIKit

import Then

final class MainTabBarController: UITabBarController {
    
    // MARK: - Property
    
    // homeViewController
    let homeViewController: HomeViewController = HomeViewController().then {
        $0.tabBarItem.title = "홈"
        $0.tabBarItem.image = UIImage(systemName: "heart")
    }
    
    // reservationListViewController
    let reservationListViewController: ReservationListViewController = ReservationListViewController().then {
        $0.tabBarItem.title = "예약내역"
        $0.tabBarItem.image = UIImage(systemName: "heart")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    // MARK: - Functions
    
    private func setTabBar() {
        tabBar.unselectedItemTintColor = .grayScale999
        tabBar.tintColor = .grayScale600
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        let homeNavigationController = UINavigationController(
            rootViewController: homeViewController
        )
        
        let reservationListNavigationController = UINavigationController(
            rootViewController: reservationListViewController
        )
        
        setViewControllers([
            homeNavigationController,
            reservationListNavigationController,
        ], animated: true)
    }
}
