# Modal Transition - iOS

### What this does

This is an alternative to the `modalFullScreen` presentation style where it presents like `fullScreen` but allows you to swipe to dismiss with a gesture and nice AnimationFormatString

It mimics the system in terms of how it looks and behaves with velocity and speed

Based off [ViewControllerTransitionExample](https://github.com/danielmgauthier/ViewControllerTransitionExample/tree/master)

### Demo

![Demo](Demo.gif)

### Usage

Use the animation with a few simple steps

#### Conform to `ModalTransitionPresentable`

```swift
class CustomViewController: UIViewController, ModalTransitionPresentable {
    var transitionManager: UIViewControllerTransitioningDelegate?
}
```

#### Present the view controller modally

```swift
let viewController = UIViewController()
viewController.configureForModalTransition()
present(viewController, animated: true)
```
