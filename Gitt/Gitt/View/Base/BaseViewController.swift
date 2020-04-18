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

    private var reachabilityRetry: Int = 0
    let reachability = try? Reachability()
    
    lazy var label_InternetError: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .medium)
        label.text = "No internet connection 😩 \nRefreshing..."
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var view_InternetError: UIView = {
        return UIView.new(backgroundColor: .gittErrorRed, alpha: 0)
    }()
    
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
    
    /// Begin execution of retry
    func execute(on queue: DispatchQueue, retry: Int = 0, closure: @escaping () -> Void) {
        let delay = getDelay(for: retry)
        queue.asyncAfter(
            deadline: DispatchTime.now() + .milliseconds(delay),
            execute: closure)
    }
    
    /// Delay for exponential backoff
    func getDelay(for n: Int) -> Int {
        let maxDelay = 300000 // 5 minutes
        let delay = Int(pow(2.0, Double(n))) * 1000
        let jitter = Int.random(in: 0...1000)
        
        print("New Delay Refresh: \(min(delay + jitter, maxDelay))")
        
        return min(delay + jitter, maxDelay)
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
    
    private func checkIfInternetConnectionHasComeBack() {
        if let connection = self.reachability?.connection {
            if connection == .unavailable {
                self.execute(on: DispatchQueue.main, retry: self.reachabilityRetry) {
                    self.reachabilityRetry += 1
                    NotificationCenter.default.post(name: AppNotificationName.refresh, object: nil)
                    self.checkIfInternetConnectionHasComeBack()
                }
            }
        }
    }
    
    private func setupReachability() {
        self.reachability?.whenReachable = { reachability in
            self.toggleInternetStatusView(isHidden: true)
        }
        self.reachability?.whenUnreachable = { _ in
            NotificationCenter.default.post(name: AppNotificationName.loadOffline, object: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                self.toggleInternetStatusView(isHidden: false)
                self.checkIfInternetConnectionHasComeBack()
            }
        }
        
        do {
            try self.reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        self.layoutActivityIndicator()
        
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 34.0),
            .foregroundColor: UIColor.textColor
        ]
        
        self.view_InternetError.addSubview(self.label_InternetError)
        self.label_InternetError.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.label_InternetError.centerXAnchor.constraint(equalTo: self.view_InternetError.centerXAnchor),
            self.label_InternetError.centerYAnchor.constraint(equalTo: self.view_InternetError.centerYAnchor)
        ])
    }
    
    private func toggleInternetStatusView(isHidden: Bool) {
        if !isHidden, let topMostController = UIViewController.current() {
            topMostController.view.addSubview(self.view_InternetError)
            self.view_InternetError.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.view_InternetError.heightAnchor.constraint(equalToConstant: 50.0),
                self.view_InternetError.topAnchor.constraint(equalTo: topMostController.view.safeAreaLayoutGuide.topAnchor),
                self.view_InternetError.leadingAnchor.constraint(equalTo: topMostController.view.leadingAnchor),
                self.view_InternetError.trailingAnchor.constraint(equalTo: topMostController.view.trailingAnchor)
            ])
                    
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
