//
//  BaseTabBarController.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import SnapKit
import UIKit

class BaseTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    lazy var searchSplitController: BaseSplitViewController = {
        let splitViewController =  BaseSplitViewController()
        let masterVC = SearchMasterViewController()
        let detailVC = SearchDetailViewController(selectedResult: nil)
        let masterNavController = UINavigationController(rootViewController: masterVC)
        let detailNavController = UINavigationController(rootViewController: detailVC)
        splitViewController.viewControllers = [masterNavController,detailNavController]
        splitViewController.tabBarItem = AppTabs.tabBarItem(for: .search)
        return splitViewController
    }()
    
    lazy var dummyController1: UIViewController = {
        let controller = UIViewController()
        controller.tabBarItem = AppTabs.tabBarItem(for: .recents)
        return controller
    }()
    
    lazy var dummyController2: UIViewController = {
        let controller = UIViewController()
        controller.tabBarItem = AppTabs.tabBarItem(for: .downloads)
        return controller
    }()
    
    lazy var dummyController3: UIViewController = {
        let controller = UIViewController()
        controller.tabBarItem = AppTabs.tabBarItem(for: .featured)
        return controller
    }()
    
    lazy var dummyController4: UIViewController = {
        let controller = UIViewController()
        controller.tabBarItem = AppTabs.tabBarItem(for: .more)
        return controller
    }()
    
    let reachability = try? Reachability()
    
    lazy var label_InternetError: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.text = "No internet connection 😩"
        label.textColor = .white
        return label
    }()
    
    lazy var view_InternetError: UIView = {
        return UIView.new(backgroundColor: .iSearchErrorRed, alpha: 0)
    }()
    
    // MARK: - Functions
    
    private func setupReachability() {
        self.reachability?.whenReachable = { reachability in
            self.toggleInternetStatusView(isHidden: true)
        }
        self.reachability?.whenUnreachable = { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.toggleInternetStatusView(isHidden: false)
            }
        }
        
        do {
            try self.reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func setupUI() {
        self.delegate = self
        
        self.viewControllers = [
            self.dummyController1,
            self.dummyController2,
            self.searchSplitController,
            self.dummyController3,
            self.dummyController4
        ]
        
        self.selectedIndex = 2
        
        self.view_InternetError.addSubview(self.label_InternetError)
        self.label_InternetError.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func toggleInternetStatusView(isHidden: Bool) {
        if !isHidden, let topMostController = UIViewController.current() {
            topMostController.view.addSubview(self.view_InternetError)
            self.view_InternetError.snp.makeConstraints {
                $0.top.equalTo(topMostController.view.safeAreaLayoutGuide.snp.top)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(30.0)
            }
            
            UIView.animate(withDuration: 0.5) {
                self.view_InternetError.alpha = 1.0
            }
            
        } else {
            self.view_InternetError.removeFromSuperview()
        }
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupReachability()
    }
}

// MARK: - UITabBarControllerDelegate

extension BaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return viewController is BaseSplitViewController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
