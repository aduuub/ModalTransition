//
//  ModalTransitionPresentable
//  ModalTransition
//
//  Created by Adam Wareing on 15/10/2024.
//

import UIKit

public protocol ModalTransitionPresentable: UIViewController {
    
    /// Transition delegate to store a strong reference to
    var transitionManager: UIViewControllerTransitioningDelegate? { get set }
    
    /// Optional `UIScrollView` to connect up to for swipe to dismiss. Defaults to nil
    var dismissalHandlingScrollView: UIScrollView? { get }
    
    /// Callback to updates the presentation layout. A default implementation is provided
    func updatePresentationLayout(animated: Bool)
}

// MARK: - Public

public extension ModalTransitionPresentable {
    
    func configureForModalTransition() {
        let interactionController = StandardInteractionController(viewController: self)
        let transitionManager = ModalTransitionDelegate(interactionController: interactionController)
        self.transitionManager = transitionManager
        self.transitioningDelegate = transitionManager
        self.modalPresentationStyle = .custom
    }
}

// MARK: - Default implementation

extension ModalTransitionPresentable {
    
    var dismissalHandlingScrollView: UIScrollView? { nil }

    func updatePresentationLayout(animated: Bool = false) {
        presentationController?.containerView?.setNeedsLayout()
        
        let layoutContainerIfNeeded = {
            self.presentationController?.containerView?.layoutIfNeeded()
        }
        
        guard animated else {
            layoutContainerIfNeeded()
            return
        }
            
        UIView.animate(
            withDuration: 0.3,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.0,
            options: .allowUserInteraction,
            animations: {
                layoutContainerIfNeeded()
            },
            completion: nil
        )
    }
}
