//
//  NotificationAnimator.swift
//  DynamicSizeVC
//
//  Created by Neil Jain on 11/23/19.
//  Copyright © 2019 NeilsUltimateLab. All rights reserved.
//

import UIKit

class NotificationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toVC = isPresenting ? transitionContext.viewController(forKey: .to) : transitionContext.viewController(forKey: .from),
            let toView = isPresenting ? transitionContext.view(forKey: .to) : transitionContext.view(forKey: .from)
        else { return }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        if isPresenting {
            containerView.addSubview(toView)
            toView.frame = finalFrame
            toView.frame.origin.y = -finalFrame.height
        }
        
        let animationOptions: UIView.AnimationOptions = isPresenting ? .curveEaseIn : .curveEaseOut
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: animationOptions, animations: {
            toView.frame.origin.y = self.isPresenting ? 0 : -finalFrame.height
        }) { (success) in
            if !self.isPresenting {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(true)
        }
    }
    
}
