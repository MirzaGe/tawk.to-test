//
//  ProfileViewModel.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Combine
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
    var imageBanner = BehaviorRelay<UIImage?>(value: nil)
    
    var followersPresentable = BehaviorRelay<String>(value: "Followers")
    var followingPresentable = BehaviorRelay<String>(value: "Following")
    var namePresentable = BehaviorRelay<String>(value: "Name: ")
    var companyPresentable = BehaviorRelay<String>(value: "Company: ")
    var blogPresentable = BehaviorRelay<String>(value: "Blog: ")
    var notesPresentable = BehaviorRelay<String>(value: "Notes...")
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Functions
    
    /// Put the data to the behavior relays.
    private func getPresentables() {
        self.followersPresentable.accept("Followers: \(self.user.followers ?? 0)")
        self.followingPresentable.accept("Following: \(self.user.following ?? 0)")
        self.namePresentable.accept("Name: \(self.user.name ?? "")")
        self.companyPresentable.accept("Company: \(self.user.company ?? "")")
        self.blogPresentable.accept("Blog: \(self.user.blog ?? "")")
        
        // Image Loader...
        let imageLoader = ImageLoader.shared.loadImage(from: URL(string: self.user.avatarUrl ?? "")!)
        self.cancellable = imageLoader.sink { [weak self] image in
            self?.imageBanner.accept(image)
        }
        
        // TODO: Do notes from CoreData....
        //self.followingPresentable.accept("Followers: \(self.user.following ?? 0)")
    }
    
    /// Call API to get more user data
    private func loadData() {
        self.startShimmer.accept(true)
        
        guard let userId = self.user.id else {
            self.delegate?.closeProfile()
            return
        }
        
        APIManager.GetUser(userId: userId).execute { (result) in
            self.startShimmer.accept(false)
            
            switch result {
            case let .success(user):
                self.user = user
                self.getPresentables()
                
            case let .failure(error):
                self.showError(error.localizedDescription)
            }
        }
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
    
    func viewWillDisappear() {
        self.cancellable?.cancel()
    }
}
