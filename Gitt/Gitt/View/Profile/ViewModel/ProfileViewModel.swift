//
//  ProfileViewModel.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/**
 Protocol of `ProfileViewModel`.
 */
protocol ProfileDelegate: BaseViewModelDelegate {
    /// Dismiss or pop the controller
    func closeProfile()
}

/**
 The viewmodel that the `ProfileViewController` owns.
 */
class ProfileViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    private weak var delegate: ProfileDelegate?
    private var user: User!
    
    // MARK: Visibilities
    
    /// Should the loader be hidden?
    var loaderIsHidden = BehaviorRelay<Bool>(value: true)
    /// Should the tableView be hidden? I.e. hidden whilst loader is visible
    var tableViewIsHidden = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Functions
    
    /// Function to re-do searching. Called by the refresh control
    func refresh() {
        self.users.removeAll()
        self.loadUsers(since: 0)
    }
    
    /// Do searching... call `SearchService`.
    private func loadUsers(since: Int = 0) {
        if since == 0 {
            self.loaderIsHidden.accept(false)
            self.tableViewIsHidden.accept(true)
        }
        
        APIManager.GetUsers(parameters: ["since": since]).execute { (result) in
            self.loaderIsHidden.accept(true)
            self.tableViewIsHidden.accept(false)
            
            switch result {
            case let .success(newUsers):
                newUsers.forEach { (newUser) in
                    self.users.append(newUser)
                }
                
                self.since = newUsers.last?.id ?? 0
                self.delegate?.reloadData()
                
            case let .failure(error):
                self.showError(error.localizedDescription)
            }
            
        }
    }
    
    // MARK: Overrides
    
    init(usersController: UsersDelegate?) {
        super.init()
        
        self.delegate = usersController
        self.loadUsers()
    }
    
    /// A controller lifecycle method
    func viewDidLoad() {
        
    }
}

// MARK: - UITableViewDelegate

extension UsersViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension UsersViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UserTableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as? UserTableViewCell
        
        if cell == nil {
            cell = UserTableViewCell()
        }
        
        let user = self.users[indexPath.row]
        cell?.configure(with: user)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = self.users.count - 1
        if indexPath.row == lastItem {
            
            print("Loading new sets of users....... ✅ self.since: \(self.since)")
            
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            tableView.tableFooterView = spinner
            
            self.loadUsers(since: self.since)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                tableView.tableFooterView = nil
            }
        }
    }
}
