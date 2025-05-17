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
    
    var number: String = ""
    
    
    // homeViewController

    let homeViewController: HomeViewController = HomeViewController().then {

        $0.tabBarItem.title = "홈"
        $0.tabBarItem.image = .home
    }
    
    // reservationListViewController
    let reservationListViewController: ReservationListViewController = ReservationListViewController().then {
        $0.tabBarItem.title = "예약내역"
        $0.tabBarItem.image = .reserve
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
        homeViewController.number = number
        reservationListViewController.number = number
    }
    
    // MARK: - Functions
    
    private func setTabBar() {
        tabBar.unselectedItemTintColor = .grayScale400
        tabBar.tintColor = .grayScale900
        tabBar.backgroundColor = .grayScale000
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
