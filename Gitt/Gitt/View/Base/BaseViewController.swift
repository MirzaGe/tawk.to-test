//
//  BaseViewController.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import SnapKit
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    /// Content view for the `scrollView`.
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
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
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.tintColor = .textColor
        
        let view = UIView.new(backgroundColor: .clear, isHidden: true)
        view.addSubviews(label, activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(activityIndicator.snp.bottom).offset(8.0)
            $0.centerX.equalToSuperview()
        }
        
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
        self.view_ActivityIndicatorContainer.snp.makeConstraints {
            $0.centerY.leading.trailing.equalToSuperview()
            $0.height.equalTo(50.0)
        }
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
