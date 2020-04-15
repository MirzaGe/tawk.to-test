//
//  BaseTableView.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    // MARK: - Properties

    
    // MARK: - Functions
    
    /// Useful for order progress tracking screen
    func reloadDataWithScrolling() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
    
    func reloadData(_ animated: Bool, completion: (() -> Void)? = nil) {
        self.reloadData()
        
        if animated {
            let cells = self.visibleCells
            let tableViewHeight = self.bounds.size.height
            
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
            }
            
            let delayCounter = 0
            for cell in cells {
                UIView.animate(withDuration: 1.75, delay: Double(delayCounter) * 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    cell.transform = CGAffineTransform.identity
                }) { (didFinish) in
                    if didFinish {
                        completion?()
                    }
                }
            }
        }
    }
    
    // MARK: Overrides
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.estimatedRowHeight = 100.0
        self.rowHeight = UITableView.automaticDimension
        self.estimatedSectionHeaderHeight = 0
        self.estimatedSectionFooterHeight = 0
        
        // Register custom cells.
        
        self.register(BaseTableViewCell.self, forCellReuseIdentifier: BaseTableViewCell.identifier)
        self.register(DataTableViewCell.self, forCellReuseIdentifier: DataTableViewCell.identifier)
        
        // Set the footer and header to remove extra blank lines
        
        let transluscentView = UIView()
        transluscentView.backgroundColor = .clear
        
        self.tableHeaderView = transluscentView
        self.tableFooterView = transluscentView
        
        // Few more setups
        self.keyboardDismissMode = .interactive
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
