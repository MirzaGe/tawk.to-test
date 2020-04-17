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
    
//    @IBOutlet weak var imageView_BG: UIImageView!
//    @IBOutlet weak var imageView_Banner: UIImageView!
//    
////    @IBOutlet weak var label_Followers: UILabel!
////    @IBOutlet weak var label_Following: UILabel!
////    @IBOutlet weak var label_Name: UILabel!
////    @IBOutlet weak var label_Company: UILabel!
////    @IBOutlet weak var label_Blog: UILabel!
////    @IBOutlet weak var textView_Notes: UITextView!
////    @IBOutlet weak var button_Save: UIButton!
    
    // MARK: - Functions
        
    /// Call API to get more user data
    /// Put the data to the behavior relays.
    private func loadData() {
        
    }
    
    // MARK: Overrides
    
    init(profileController: ProfileDelegate?, user: User) {
        super.init()
        
        self.delegate = profileController
        self.user = user
        self.loadData()
    }
}
