//
//  UserTableViewCell.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import UIKit
import Combine

class UserTableViewCell:
BaseTableViewCell {
    
    // MARK: - Properties
    
    private var username: UILabel!
    private var details: UILabel!
    private var imageView_Avatar: UIImageView!
    private var cancellable: AnyCancellable?
    private var animator: UIViewPropertyAnimator?
    
    // MARK: - Functions
    // MARK: Overrides
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func prepareForReuse() {
        super.prepareForReuse()
        imageView_Avatar.image = nil
        imageView_Avatar.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    
    func configure(with user: User, invert: Bool) {
        self.username.text = user.login ?? "No username"
        self.details.text = "userId: \(user.id)"
        self.cancellable = self.loadImage(for: user).sink { [unowned self] image in
            self.showImage(image: image, invert: invert)
        }
    }
    
    private func showImage(image: UIImage?, invert: Bool) {
        self.imageView_Avatar.alpha = 0.0
        self.animator?.stopAnimation(false)
        self.imageView_Avatar.image = image
        
        if invert,
            let filter = CIFilter(name: "CIColorInvert"),
            let image = image,
            let ciimage = CIImage(image: image) {
            filter.setValue(ciimage, forKey: kCIInputImageKey)
            let newImage = UIImage(ciImage: filter.outputImage!)
            self.imageView_Avatar.image = newImage
        }
        
        self.animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.imageView_Avatar.alpha = 1.0
        })
    }
    
    private func loadImage(for user: User) -> AnyPublisher<UIImage?, Never> {
        return ImageLoader.shared.loadImage(from: URL(string: user.avatarUrl ?? "")!)
    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        self.imageView_Avatar = UIImageView()
        stackView.addArrangedSubview(self.imageView_Avatar)
        NSLayoutConstraint.activate([
            self.imageView_Avatar.widthAnchor.constraint(equalToConstant: 60.0),
            self.imageView_Avatar.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
        self.username = UILabel()
        self.username.font = .boldSystemFont(ofSize: 14)
        self.username.numberOfLines = 0
        self.username.lineBreakMode = .byWordWrapping
        
        self.details = UILabel()
        self.details.font = .systemFont(ofSize: 14)
        self.details.numberOfLines = 3
        self.details.lineBreakMode = .byTruncatingTail
        
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .equalSpacing
        textStackView.alignment = .leading
        textStackView.spacing = 4
        textStackView.addArrangedSubview(self.username)
        textStackView.addArrangedSubview(self.details)
        stackView.addArrangedSubview(textStackView)
    }
}
