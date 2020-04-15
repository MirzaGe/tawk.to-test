//
//  SearchDetailViewController.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Kingfisher
import SnapKit
import RxCocoa
import RxSwift
import UIKit

/**
 The controller for Search detail screen.
 For now, this view is best fit for movies type.
 */
class SearchDetailViewController: BaseViewController {
    
    // MARK: - Properties
    
    /// The object used in `BaseSplitViewController`.
    /// Used for handling collapse.
    /// Can be moved to viewModel in the future.
    var hasData: Bool = false
    
    private let disposeBag = DisposeBag()
    private var viewModel: SearchDetailViewModel!
    
    /// Useful for iPads refreshign layout.
    private var contentViewWidthConstraint: Constraint?
    
    private lazy var imageView_Artwork: UIImageView = {
        return UIImageView(image: UIImage(named: "ic_placeholder"))
    }()
    
    private lazy var label_Title: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var label_GenreDate: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.alpha = 0.8
        return label
    }()
    
    private lazy var label_AboutTitle: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.text = "About the Movie"
        return label
    }()
    
    private lazy var label_AboutValue: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        label.alpha = 0.8
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var label_ContentRating: UILabel = {
        let label = UILabel()
        label.textColor = .textColor
        label.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        label.setupLayer(cornerRadius: 0, borderWidth: 1.0, borderColor: .textColor)
        return label
    }()
    
    private lazy var button_Buy: GetButton = {
        return GetButton(type: .custom)
    }()
    
    private lazy var button_Rent: GetButton = {
        return GetButton(type: .custom)
    }()
    
    private lazy var view_Separator: UIView = {
        return UIView.new(backgroundColor: .systemGray3)
    }()
    
    // MARK: - Functions
    
    private func setupBindings() {
        weak var weakSelf = self
        
        self.viewModel.artworkResource.subscribe(onNext: { resource in
            let placeholder = KFCrossPlatformImage(named: "ic_placeholder")
            weakSelf?.imageView_Artwork.kf.setImage(
                with: resource,
                placeholder: placeholder) { (result) in
                    switch result {
                    case .failure: weakSelf?.imageView_Artwork.image = placeholder
                    default: break
                    }
            }
        }).disposed(by: self.disposeBag)
        
        self.viewModel.trackTitlePresentable
            .bind(to: self.label_Title.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.genreDatePresentable
            .bind(to: self.label_GenreDate.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.aboutPresentable
            .bind(to: self.label_AboutValue.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.contentRatingPresentable
            .bind(to: self.label_ContentRating.rx.text)
            .disposed(by: self.disposeBag)
        
        self.viewModel.buyButtonTitlePresentable.subscribe(onNext: { title in
            weakSelf?.button_Buy.setup(
                title,
                normalFont: UIFont.systemFont(ofSize: 14.0, weight: .medium),
                normalTextColor: .systemBlue,
                backgroundColor: .clear,
                horizontalAlignment: .center
            )
        }).disposed(by: self.disposeBag)
        
        self.viewModel.rentButtonTitlePresentable.subscribe(onNext: { title in
            weakSelf?.button_Rent.setup(
                title,
                normalFont: UIFont.systemFont(ofSize: 14.0, weight: .medium),
                normalTextColor: .systemBlue,
                backgroundColor: .clear,
                horizontalAlignment: .center
            )
        }).disposed(by: self.disposeBag)

    }
    
    
    private func setupUI() {
        // We get the correct screenwidth of the detail controller in a split controller.
        let screenWidth = self.navigationController?.view.frame.width ?? AppConfig.screenWidth
        // Then add scrollView
        self.addScrollView(to: self.view, shouldExtendToTopEdge: true, screenWidth: screenWidth ) { (contentView, topConstraint, contentViewWidthConstraint) in
            self.contentViewWidthConstraint = contentViewWidthConstraint
            
            contentView.addSubviews(
                self.imageView_Artwork,
                self.label_Title,
                self.label_ContentRating,
                self.label_GenreDate,
                self.view_Separator,
                self.label_AboutTitle,
                self.label_AboutValue,
                self.button_Buy,
                self.button_Rent
            )
            
            self.imageView_Artwork.snp.makeConstraints {
                $0.top.equalToSuperview().inset(8.0)
                $0.leading.equalToSuperview().inset(16.0)
                $0.width.equalTo(150.0)
                $0.height.equalTo(220.0)
            }
            
            self.label_Title.snp.makeConstraints {
                $0.top.equalTo(self.imageView_Artwork).offset(8.0)
                $0.leading.equalTo(self.imageView_Artwork.snp.trailing).offset(8.0)
                $0.trailing.equalToSuperview().inset(16.0)
            }
            
            self.label_ContentRating.snp.makeConstraints {
                $0.top.equalTo(self.label_Title.snp.bottom)
                $0.leading.equalTo(self.label_Title)
            }
            
            self.label_GenreDate.snp.makeConstraints {
                $0.top.equalTo(self.label_ContentRating.snp.bottom).offset(8.0)
                $0.height.equalTo(20.0)
                $0.leading.equalTo(self.label_Title)
            }
            
            self.view_Separator.snp.makeConstraints {
                $0.height.equalTo(1.0)
                $0.top.equalTo(self.imageView_Artwork.snp.bottom).offset(16.0)
                $0.leading.equalToSuperview().inset(16.0)
                $0.trailing.equalToSuperview()
            }
            
            self.label_AboutTitle.snp.makeConstraints {
                $0.top.equalTo(self.view_Separator.snp.bottom).offset(8.0)
                $0.leading.trailing.equalToSuperview().inset(16.0)
            }
            
            self.label_AboutValue.snp.makeConstraints {
                $0.top.equalTo(self.label_AboutTitle.snp.bottom).offset(8.0)
                $0.leading.trailing.equalTo(self.label_AboutTitle)
                $0.bottom.equalToSuperview().inset(50.0)
            }
            
            self.button_Rent.snp.makeConstraints {
                $0.bottom.equalTo(self.imageView_Artwork).offset(-5.0)
                $0.leading.equalTo(self.label_Title)
                $0.width.equalTo(110.0)
            }
            
            self.button_Buy.snp.makeConstraints {
                $0.bottom.equalTo(self.button_Rent.snp.top).offset(-8.0)
                $0.leading.equalTo(self.label_Title)
                $0.width.equalTo(100.0)
            }
        }
    }
    
    // MARK: - Initialization
    
    init(selectedResult: Result?) {
        super.init(nibName: nil, bundle: nil)
        
        self.hasData = selectedResult != nil
        self.viewModel = SearchDetailViewModel(searchDetailController: self, selectedResult: selectedResult)
    }
    
    private init() { super.init(nibName: nil, bundle: nil) }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Overrides
    
    override func loadView() {
        super.loadView()
        
        self.setupUI()
        self.setupBindings()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.viewWillDisappear()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        self.contentViewWidthConstraint?.update(offset: size.width)
        self.scrollView.setNeedsLayout()
        self.scrollView.layoutIfNeeded()
    }
}

// MARK: - SearchDetailDelegate

extension SearchDetailViewController: SearchDetailDelegate { }
