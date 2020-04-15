//
//  UIViewController+iSearch.swift
//  iSearch
//
//  Created by Glenn Von Posadas on 4/9/20.
//  Copyright © 2020 CitusLabs. All rights reserved.
//

import SnapKit
import UIKit

var windowScene: UIScene? = {
    let windowScene = UIApplication.shared
    .connectedScenes
    .filter { $0.activationState == .foregroundActive }
    .first
    return windowScene
}()

var windowRootController: UIViewController? {
    if let window = windowScene as? UIWindowScene {
        return window.windows.last?.rootViewController
    }
    
    return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
}

/// Category for any controller.
extension UIViewController {
    /// The completion callback for the ```alert```.
    typealias AlertCallBack = ((_ userDidTapOk: Bool) -> Void)
        
    /// Class function to get the current or top most screen.
    class func current(controller: UIViewController? = windowRootController) -> UIViewController? {
        guard let controller = controller else { return nil }
        
        if let navigationController = controller as? UINavigationController {
            return current(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return current(controller: selected)
            }
        }
        if let presented = controller.presentedViewController {
            return current(controller: presented)
        }
        return controller
    }
    
    /// Adds a scrollView and attached it as a subview for `BaseViewController` subclassing controllers.
    /// Adds as well a clear view that serves as a stretcher for the scrollView's width.
    ///
    /// - Parameter shouldExtendToTopEdge: If true, top is equalToSuperView. Otherwise, set to 64.0
    /// - Parameter screenWidth: Useful for split controllers.
    /// - Parameter block: Accepts the `containerView` which can be used in the completion for setting up it's subviews.
    func addScrollView(
        to aView: UIView,
        shouldExtendToTopEdge: Bool = true,
        screenWidth: CGFloat = AppConfig.screenWidth,
        block: ((_ contentView: UIView, _ topScrollViewConstraint: Constraint?, _ contentViewWidthConstraint: Constraint?) -> Void)) {
        var topConstraint: Constraint?
        var contentViewWidthConstraint: Constraint?
        
        guard let baseVC = self as? BaseViewController else { return }
        aView.addSubview(baseVC.scrollView)
        baseVC.scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            if shouldExtendToTopEdge {
                topConstraint = $0.top.equalToSuperview().constraint
            } else {
                // Can be a one liner, but this is just an experiment.
                // We could use `constraintToTop`.
                topConstraint = $0.top.equalToSuperview().inset(64.0).constraint
            }
        }
        
        baseVC.contentView = UIView()
        baseVC.contentView.backgroundColor = .clear
        baseVC.scrollView.addSubview(baseVC.contentView)
        baseVC.contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            contentViewWidthConstraint = $0.width.equalTo(screenWidth).constraint
        }
        
        // Now let the controller add its subviews in this block
        block(baseVC.contentView, topConstraint, contentViewWidthConstraint)
    }
    
    /**
     Presents an alertController with completion.
     - parameter title: The title of the alert.
     - parameter message: The body of the alert, nullable, since we can just sometimes use the title parameter.
     - parameter okButtonTitle: the title of the okay button.
     - parameter cancelButtonTitle: The title of the cancel button, defaults to nil, nullable.
     - parameter completion: The ```LLFAlertCallBack```, returns Bool. True when the user taps on the OK button, otherwise false.
     */
    func alert(
        title: String,
        message: String? = nil,
        okayButtonTitle: String,
        cancelButtonTitle: String? = nil,
        withBlock completion: AlertCallBack?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okayButtonTitle, style: .default) { _ in
            completion?(true)
        }
        alertController.addAction(okAction)
        
        if let cancelButtonTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default) { _ in
                completion?(false)
            }
            alertController.addAction(cancelAction)
        }
        
        alertController.view.tintColor = .black
        present(alertController, animated: true, completion: nil)
    }
}

