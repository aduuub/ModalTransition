//
//  InteractionControlling.swift
//  ModalTransition
//
//  Created by Adam Wareing on 15/10/2024.
//

import UIKit

/// A protocol subclassing `UIViewControllerInteractiveTransitioning` that can store if the interaction is in progress or not
protocol InteractionControlling: UIViewControllerInteractiveTransitioning {
    var interactionInProgress: Bool { get }
}
