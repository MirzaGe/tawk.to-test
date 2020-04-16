//
//  BaseViewController.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Properties
    
    var backgroundColor: UIColor {
        get {
            self.view.backgroundColor ?? .backgroundColor
        } set {
            self.view.backgroundColor = newValue
        }
    }

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .textColor
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor : UIColor.textColor,
            .font: UIFont.systemFont(ofSize: 14.0)
        ]
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh", attributes: attributes)
        return refreshControl
    }()
    
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        return tableView
    }()

    lazy var view_ActivityIndicatorContainer: UIView = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = .textColor
        label.text = "LOADING"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.tintColor = .textColor
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView.new(backgroundColor: .clear, isHidden: true)
        view.addSubviews(label, activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: view.topAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 8.0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        return view
    }()
    
    // MARK: - Functions
    
    /// Add  pull to refresh to tableView
    func addPullToRefreshControl(to tableView: UITableView, inset: CGFloat = 0) {
        self.refreshControl.bounds = CGRect(
            x: self.refreshControl.bounds.minX,
            y: inset,
            width: self.refreshControl.bounds.size.width,
            height: self.refreshControl.bounds.size.height
        )
        
        tableView.refreshControl = self.refreshControl
    }
    
    /// Layout activity indicator view.
    func layoutActivityIndicator() {
        self.view.addSubview(self.view_ActivityIndicatorContainer)
        self.view_ActivityIndicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.view_ActivityIndicatorContainer.heightAnchor.constraint(equalToConstant: 50.0),
            self.view_ActivityIndicatorContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.view_ActivityIndicatorContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.view_ActivityIndicatorContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
        
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.backgroundColor = .backgroundColor
        self.layoutActivityIndicator()
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34.0),
            .foregroundColor: UIColor.textColor
        ]
    }
}
