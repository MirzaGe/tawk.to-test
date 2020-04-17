//
//  BaseViewModel.swift
//  Gitt
//
//  Created by Glenn Von Posadas on 4/10/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// The Base Delegate of all ViewModels.
protocol BaseViewModelDelegate: class {
    func reloadData()
}

/// Make some protocols optional.
extension BaseViewModelDelegate {
    func reloadData() { }
}

/**
 The Base ViewModel of all ViewModels of the app.
 This contains the common properties of all viewModels.
 */
class BaseViewModel: NSObject {
    
    // MARK: - Properties
    
    // MARK: - Functions
    
    @objc func refresh() { }
    
    func showError(_ error: Error) {
        if (error as NSError).code == -1009 { return }
        UIViewController.current()?.alert(
            title: "Oops!",
            message: "An error has occured: \(error.localizedDescription)",
            okayButtonTitle: "OK",
            cancelButtonTitle: nil,
            withBlock: nil
        )
    }
    
    override init() {
        super.init()
        
        // Be notified from internet status.
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.refresh),
            name: AppNotificationName.refresh,
            object: nil
        )
    }
}
