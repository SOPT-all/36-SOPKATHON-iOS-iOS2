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
    
    var isLoginScreenPresented = true // 나중에 false로 설정
    
    // homeViewController

    let homeViewController: ReservationViewController = ReservationViewController().then {

        $0.tabBarItem.title = "홈"
        $0.tabBarItem.image = .home
    }
    
    // reservationListViewController
    let reservationListViewController: ReservationCompleteViewController = ReservationCompleteViewController().then {
        $0.tabBarItem.title = "예약내역"
        $0.tabBarItem.image = .reserve
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isLoginScreenPresented {
            let loginViewController = LoginViewController()
            
            let nav = UINavigationController(rootViewController: loginViewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)

            self.isLoginScreenPresented.toggle()
        }
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
