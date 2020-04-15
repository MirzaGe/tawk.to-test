//
//  AppTabs.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

enum AppTabs: Int {
    case recents = 0
    case downloads
    case search
    case featured
    case more

    static func tabBarItem(for tab: AppTabs) -> UITabBarItem {
        switch tab {
        case .recents: return UITabBarItem(tabBarSystemItem: .recents, tag: tab.rawValue)
        case .downloads: return UITabBarItem(tabBarSystemItem: .downloads, tag: tab.rawValue)
        case .search: return UITabBarItem(tabBarSystemItem: .search, tag: tab.rawValue)
        case .featured: return UITabBarItem(tabBarSystemItem: .featured, tag: tab.rawValue)
        case .more: return UITabBarItem(tabBarSystemItem: .more, tag: tab.rawValue)
        }
    }
}
