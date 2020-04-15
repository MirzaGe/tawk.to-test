//
//  BaseSplitViewController.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

/**
 The base split controller, intended to for Search tab.
 Should other tabs need to use this, then handle delegate properly.
 */
class BaseSplitViewController: UISplitViewController {

    // MARK: - Properties
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func loadView() {
        super.loadView()
        
        self.preferredDisplayMode = .allVisible
        self.delegate = self
        
        if AppConfig.IS_IPAD {
            self.maximumPrimaryColumnWidth = AppConfig.screenWidth * 0.50
            self.minimumPrimaryColumnWidth = AppConfig.screenWidth * 0.40
        }
    }
}

// MARK: - UISplitViewControllerDelegate

extension BaseSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let navCon = secondaryViewController as? UINavigationController,
            let detail = navCon.topViewController as? SearchDetailViewController,
            !detail.hasData {
            return true
        }
        
        return false
    }
}
