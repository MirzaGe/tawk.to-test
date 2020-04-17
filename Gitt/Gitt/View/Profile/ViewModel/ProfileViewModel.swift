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
    
    /// Determines the state of shimmer
    var startShimmer = BehaviorRelay<Bool>(value: true)
    var imageUrl = BehaviorRelay<URL?>(value: nil)

    var followersPresentable = BehaviorRelay<String>(value: "")
    var followingPresentable = BehaviorRelay<String>(value: "")
    var namePresentable = BehaviorRelay<String>(value: "")
    var companyPresentable = BehaviorRelay<String>(value: "")
    var blogPresentable = BehaviorRelay<String>(value: "")
    var notesPresentable = BehaviorRelay<String>(value: "")
    
    // MARK: - Functions
        
    /// Call API to get more user data
    /// Put the data to the behavior relays.
    private func loadData() {
        guard let userId = self.user.id else {
            self.delegate?.closeProfile()
            return
        }
        
        //APIManager.GetUsers
    }
    
    // MARK: Events
    
    func save() {
        
    }
    
    // MARK: Overrides
    
    init(profileController: ProfileDelegate?, user: User) {
        super.init()
        
        self.delegate = profileController
        self.user = user
        self.loadData()
    }
}
