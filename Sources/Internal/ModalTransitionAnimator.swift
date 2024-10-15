//
//  ModalTransitionAnimator
//  ModalTransition
//
//  Created by Adam Wareing on 15/10/2024.
//

import UIKit

/// An animator conforming to ``UIViewControllerAnimatedTransitioning`` for presenting a modal
class ModalTransitionAnimator: NSObject {

    private let presenting: Bool
    private let animationDuration: TimeInterval
    
    /// Create a new instance of the animator
    /// - Parameter presenting: is the animator used for presenting?
    init(presenting: Bool, animationDuration: TimeInterval = 0.5) {
        self.presenting = presenting
        self.animationDuration = animationDuration
        super.init()
    }
    
    /// Animates a `UIViewController`
    /// - Parameters:
    ///   - viewController: view controller to animate
    ///   - frame: destination frame
    ///   - transitionContext: transition context to animate in
    private func animate(
        viewController: UIViewController,
        toFrame frame: CGRect,
        using transitionContext: UIViewControllerContextTransitioning
    ) {
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), dampingRatio: 1.0) {
            viewController.view.frame = frame
        }
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        animator.startAnimation()
    }
}

// MARK: - UIViewControllerAnimatedTransitioning

extension ModalTransitionAnimator: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if presenting {
            animatePresentation(using: transitionContext)
        } else {
            animateDismissal(using: transitionContext)
        }
    }

    private func animatePresentation(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        transitionContext.containerView.addSubview(presentedViewController.view)
        let presentedFrame = transitionContext.finalFrame(for: presentedViewController)
        
        // Set initial frame
        presentedViewController.view.frame = CGRect(
            x: presentedFrame.minX,
            y: transitionContext.containerView.bounds.height,
            width: presentedFrame.width,
            height: presentedFrame.height
        )
        
        animate(
            viewController: presentedViewController,
            toFrame: presentedFrame,
            using: transitionContext
        )
    }

    private func animateDismissal(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presentedViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let presentedFrame = transitionContext.finalFrame(for: presentedViewController)
        let dismissedFrame = CGRect(
            x: presentedFrame.minX,
            y: transitionContext.containerView.bounds.height,
            width: presentedFrame.width,
            height: presentedFrame.height
        )

        animate(
            viewController: presentedViewController,
            toFrame: dismissedFrame,
            using: transitionContext
        )
    }
}
