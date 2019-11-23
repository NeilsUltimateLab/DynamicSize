//
//  NotificationPresentationController.swift
//  DynamicSizeVC
//
//  Created by Neil Jain on 11/23/19.
//  Copyright © 2019 NeilsUltimateLab. All rights reserved.
//

import UIKit

class NotificationPresentationController: UIPresentationController {
    
    private lazy var chromeView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupChromeView() {
        guard let containerView = self.containerView else { return }
        containerView.addSubview(chromeView)
        chromeView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        chromeView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        chromeView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        chromeView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    override func presentationTransitionWillBegin() {
        setupChromeView()
        presentedView?.layer.cornerRadius = 16
        presentedView?.layer.masksToBounds = true
        presentedView?.window?.windowLevel = .statusBar
        
        guard let coordinate = presentedViewController.transitionCoordinator else {
            chromeView.alpha = 1
            return
        }
        
        coordinate.animate(alongsideTransition: { (_) in
            self.chromeView.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            chromeView.alpha = 0
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.chromeView.alpha = 0
        }, completion: nil)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        self.presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = self.containerView, let presentedView = self.presentedView else { return .zero }
        let targetSize = CGSize(width: containerView.frame.width, height: UIView.layoutFittingCompressedSize.height)
        var size = presentedView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        if size.height > containerView.frame.height {
            size.height = containerView.frame.height
        }
        return CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    
}
