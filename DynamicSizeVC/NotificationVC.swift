//
//  NotificationVC.swift
//  DynamicSizeVC
//
//  Created by Neil Jain on 11/23/19.
//  Copyright © 2019 NeilsUltimateLab. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var value: String = ""
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
        
    private func setup() {
        self.label.text = value
        self.dateFormatter.dateFormat = "hh:mm a"
        self.timeLabel.text = dateFormatter.string(from: Date())
    }
    
    @IBAction func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NotificationVC {
    static func initialize(for label: String) -> NotificationVC {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NotificationVC") as? NotificationVC else {
            fatalError()
        }
        vc.value = label
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = vc
        vc.modalPresentationCapturesStatusBarAppearance = true
        return vc
    }
}

extension NotificationVC: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return NotificationPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NotificationAnimator()
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = NotificationAnimator()
        animator.isPresenting = false
        return animator
    }
}
