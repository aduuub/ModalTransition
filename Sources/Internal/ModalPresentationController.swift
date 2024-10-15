//
//  ModalPresentationController
//  ModalTransition
//
//  Created by Adam Wareing on 15/10/2024.
//

import UIKit

/// A custom presentation controller that manages the fade of the background view
class ModalPresentationController: UIPresentationController {
    
    private lazy var fadeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.alpha = 0
        return view
    }()
    
    func setFadeViewAlpha(_ alpha: CGFloat) {
        fadeView.alpha = alpha
    }
    
    private func addFadeView() {
        guard let containerView = containerView else {
            return
        }
        
        containerView.addSubview(fadeView)
        
        containerView.leftAnchor.constraint(equalTo: fadeView.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: fadeView.rightAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: fadeView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: fadeView.bottomAnchor).isActive = true
    }
    
    override func presentationTransitionWillBegin() {
        addFadeView()
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            fadeView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.fadeView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            fadeView.alpha = 0.0
            return
        }
        
        if !coordinator.isInteractive {
            coordinator.animate(alongsideTransition: { _ in
                self.fadeView.alpha = 0.0
            })
        }
    }
}
