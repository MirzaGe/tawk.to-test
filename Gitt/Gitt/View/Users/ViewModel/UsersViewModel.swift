//
//  UsersViewModel.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/**
 Protocol of `UsersViewModel`.
 */
protocol UsersDelegate: BaseViewModelDelegate {
    // func showDetail(with result: Result)
}

/**
 The viewmodel that the `UsersViewController` owns.
 */
class UsersViewModel: BaseViewModel {
    
    // MARK: - Properties
    
    /// The last seen user id.
    private var since: Int = 0
    private weak var delegate: UsersDelegate?
    
    var users = [User]()
    
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
        self.loaderIsHidden.accept(false)
        self.tableViewIsHidden.accept(true)
        
        APIManager.GetUsers(parameters: ["since": 0]).execute { (result) in
            self.loaderIsHidden.accept(true)
            self.tableViewIsHidden.accept(false)
            
            switch result {
            case let .success(newUsers):
                newUsers.forEach { (newUser) in
                    self.users.append(newUser)
                }
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
}
