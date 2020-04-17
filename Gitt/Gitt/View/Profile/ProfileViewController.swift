//
//  ProfileViewController.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/17/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

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
    
    var user: User!
    
    // MARK: - Functions
    
    private func setupBindings() {
        
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
    }
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
        self.setupBindings()
    }
}
