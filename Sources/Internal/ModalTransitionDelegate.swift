//
//  ModalTransitionDelegate
//  ModalTransition
//
//  Created by Adam Wareing on 15/10/2024.
//

import UIKit

/// A delegate that manages the transition
class ModalTransitionDelegate: NSObject {

    private var interactionController: InteractionControlling?

    init(interactionController: InteractionControlling?) {
        self.interactionController = interactionController
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ModalTransitionDelegate: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalTransitionAnimator(presenting: true)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalTransitionAnimator(presenting: false)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactionController = interactionController, interactionController.interactionInProgress else {
            return nil
        }
        return interactionController
    }
}
