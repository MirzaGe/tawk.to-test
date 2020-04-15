//
//  DataTableViewCell.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

/**
 Enum to determine the type of the current cell.
 */
enum DataCellType {
    /// The short is used for songs kind of cell, with square-ish artwork imageView.
    case short
    /// The long type is used for books and movies.
    case long
}

/**
 The protocol of `DataTableViewCell`.
 This will contian the events from the views, such as GetButton.
 */
protocol DataCellDelegate { }

/**
 The `DataTableViewCell` is merely the common cell to be used in this project.
 A collection cell was put into consideration but it would take time.
 Collection cell to group songs and other `kind`s, much like the original Itunes Store app.
 
 However though, it is being aimed that the artwork to be dynamic based on `kind`.
 
 TODO: Add star rating view.
 */
class DataTableViewCell: BaseTableViewCell {

    // MARK: - Properties
    
    private var constraint_ArtworkHeight: Constraint?
    private var constraint_ArtworkWidth: Constraint?
    private var constraint_ButtonWidth: Constraint?
    
    private lazy var imageView_Artwork: UIImageView = {
        return UIImageView(image: UIImage(named: "ic_placeholder"))
    }()
    
    private lazy var label_Title: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var label_Subtitle: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.alpha = 0.5
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var label_Date: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.numberOfLines = 1
        label.isHidden = true
        return label
    }()
    
    private lazy var stackView_Labels: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.label_Title,
            self.label_Subtitle,
            self.label_Date
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var button_Get: GetButton = {
        return GetButton(type: .custom)
    }()
    
    private lazy var imageView_DisclosureIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "ic_chevron_right")?
                .withTintColor(UIColor.textColor))
        imageView.alpha = 0.5
        return imageView
    }()
    
    private var cellType: DataCellType!
    
    // MARK: - Functions
    
    func setupCell(data: Result, type: DataCellType) {
        self.cellType = type
        
        self.label_Date.isHidden = data.dateLabelIsHidden
        self.button_Get.isHidden = data.getButtonIsHidden
        self.imageView_DisclosureIcon.isHidden = !data.getButtonIsHidden
        
        self.label_Title.text = data.titlePresentable
        self.label_Subtitle.text = data.subtitlePresentable
        self.label_Date.text = data.datePresentable
        
        let placeholder = KFCrossPlatformImage(named: "ic_placeholder")
        self.imageView_Artwork.kf.setImage(
            with: data.artworkResource,
            placeholder: placeholder) { (result) in
                switch result {
                case .failure: self.imageView_Artwork.image = placeholder
                default: break
                }
        }
        
        switch type {
        case .short:
            self.button_Get.setup(
                data.getButtonTitlePresentable,
                normalFont: UIFont.systemFont(ofSize: 14.0, weight: .medium),
                normalTextColor: .systemBlue,
                backgroundColor: .clear,
                horizontalAlignment: .center
            )
            
            self.constraint_ArtworkWidth?.update(offset: 50.0)
            self.constraint_ArtworkHeight?.update(offset: 50.0)
            
        case .long:
            self.button_Get.setup(
                "GET",
                normalFont: UIFont.systemFont(ofSize: 14.0, weight: .medium),
                normalTextColor: .systemBlue,
                backgroundColor: .clear,
                horizontalAlignment: .center
            )
            
            self.constraint_ArtworkWidth?.update(offset: 60.0)
            self.constraint_ArtworkHeight?.update(offset: 90.0)
        }
    }
    
    // MARK: Overrides

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .default
        
        self.contentView.addSubviews(
            self.imageView_Artwork,
            self.button_Get,
            self.imageView_DisclosureIcon,
            self.stackView_Labels
        )
        
        self.imageView_Artwork.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
            self.constraint_ArtworkWidth = $0.width.equalTo(60.0).constraint
            self.constraint_ArtworkHeight = $0.height.equalTo(90.0).priority(.high).constraint
        }
        
        self.button_Get.snp.makeConstraints {
            $0.height.equalTo(30.0)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.0)
            self.constraint_ButtonWidth = $0.width.equalTo(60.0).constraint
        }
            
        self.imageView_DisclosureIcon.snp.makeConstraints {
            $0.width.equalTo(15.0)
            $0.height.equalTo(15.0)
            $0.trailing.centerY.equalTo(self.button_Get)
        }
        
        self.stackView_Labels.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.imageView_Artwork.snp.trailing).offset(8.0)
            $0.trailing.equalTo(self.button_Get.snp.leading).offset(-8.0)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        // self.setHighlightedAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
