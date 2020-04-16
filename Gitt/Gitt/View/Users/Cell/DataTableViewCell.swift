//
//  DataTableViewCell.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import UIKit
import Combine

class DataTableViewCell: BaseTableViewCell {
    
    // MARK: - Properties
    
    private var title: UILabel!
    private var subtitle: UILabel!
    private var poster: UIImageView!
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
        poster.image = nil
        poster.alpha = 0.0
        animator?.stopAnimation(true)
        cancellable?.cancel()
    }
    
//    func configure(with movie: Result) {
//        title.text = movie.titlePresentable
//        subtitle.text = movie.subtitlePresentable
//        cancellable = loadImage(for: movie).sink { [unowned self] image in self.showImage(image: image) }
//    }
    
    private func showImage(image: UIImage?) {
        poster.alpha = 0.0
        animator?.stopAnimation(false)
        poster.image = image
        animator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.poster.alpha = 1.0
        })
    }
    
//    private func loadImage(for movie: Result) -> AnyPublisher<UIImage?, Never> {
//        return ImageLoader.shared.loadImage(from: URL(string: movie.artworkResource.downloadURL.absoluteString)!)
//    }
    
    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        poster = UIImageView()
        stackView.addArrangedSubview(poster)
        NSLayoutConstraint.activate([
            poster.widthAnchor.constraint(equalToConstant: 60),
            poster.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        title = UILabel()
        title.font = .boldSystemFont(ofSize: 14)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        
        subtitle = UILabel()
        subtitle.font = .systemFont(ofSize: 14)
        subtitle.numberOfLines = 3
        subtitle.lineBreakMode = .byTruncatingTail
        
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .equalSpacing
        textStackView.alignment = .leading
        textStackView.spacing = 4
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(subtitle)
        stackView.addArrangedSubview(textStackView)
    }
}
