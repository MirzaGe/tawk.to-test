//
//  ProfileViewController.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

/**
 The controller for profile screen.
 */
class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView_BG: UIImageView!
    @IBOutlet weak var imageView_Banner: UIImageView!
    
    @IBOutlet weak var label_Followers: UILabel!
    @IBOutlet weak var label_Following: UILabel!
    @IBOutlet weak var label_Name: UILabel!
    @IBOutlet weak var label_Company: UILabel!
    @IBOutlet weak var label_Blog: UILabel!
    @IBOutlet weak var textView_Notes: UITextView!
    @IBOutlet weak var button_Save: UIButton!
    
    @IBOutlet weak var view_ShimmerContainer: UIView!
    @IBOutlet var view_Shimmers: [UIView]!
    
    var user: User!
    
    private var viewModel: ProfileViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Functions
    
    private func setupBindings() {
        weak var weakSelf = self
        
        self.viewModel = ProfileViewModel(profileController: self, user: self.user)
        
        self.viewModel.followersPresentable
            .bind(to: self.label_Followers.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.followingPresentable
            .bind(to: self.label_Following.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.namePresentable
            .bind(to: self.label_Name.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.companyPresentable
            .bind(to: self.label_Company.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.blogPresentable
            .bind(to: self.label_Blog.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.notesPresentable
            .bind(to: self.textView_Notes.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.startShimmer
            .subscribe(onNext: { startShimmer in
                weakSelf?.view_ShimmerContainer.isHidden = !startShimmer
                if startShimmer {
                    weakSelf?.view_Shimmers.forEach({ $0.shimmer() })
                }
            }).disposed(by: self.disposeBag)
    }
    
    private func setupUI() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        self.view.addSubview(blurredEffectView)
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blurredEffectView.topAnchor.constraint(equalTo: self.imageView_BG.topAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: self.imageView_BG.bottomAnchor),
            blurredEffectView.leadingAnchor.constraint(equalTo: self.imageView_BG.leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: self.imageView_BG.trailingAnchor)
        ])
        
        self.view.bringSubviewToFront(self.imageView_Banner)
        self.view.bringSubviewToFront(self.view_ShimmerContainer)
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
    }
}

// MARK: -

extension ProfileViewController: ProfileDelegate {
    func closeProfile() {
        self.navigationController?.popViewController(animated: true)
    }
}
