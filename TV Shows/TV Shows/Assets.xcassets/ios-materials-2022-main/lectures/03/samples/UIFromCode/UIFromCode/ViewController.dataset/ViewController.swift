//
//  ViewController.swift
//  UIFromCode
//
//  Created by Filip Gulan on 08.07.2021..
//

import UIKit

// Good practice tells us that you should always start with FINAL keyword,
// meaning you class will not be subclassable
final class ViewController: UIViewController {

    var activityIndicatorView: UIActivityIndicatorView?
    var showActivityButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // As we want to write a production ready code, you should start to group
        // chunks of code into functions, and not keep everything in one place.
        setupUI()
    }
}

// MARK: - Private UI setup

private extension ViewController {

    // We can either use PRIVATE keyword on extension, or prefix each specific method with access modifier

    func setupUI() {
        setupButton()
        setupActivityIndicator()
    }

    func setupButton() {
        // # Create and setup button
        // If you choose to not use predefined button types, you will lose some of its feature.
        // To be more specific, you will need to implement it itself (highlighting)
        // Because UIButton class is pretty old, you don't have support for closure based actions,
        // to you need to use something called "Target Action" pattern via ObjC runtime magic called Selector
        let showActivityButton = UIButton(type: .system)
        showActivityButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        showActivityButton.setTitle("Show Activity", for: .normal)
        showActivityButton.setTitleColor(.red, for: .normal)
        showActivityButton.addTarget(self, action: #selector(showActivtiyIndicatorActionHandler), for: .touchUpInside)

        // Add button to as subview to our parent view
        view.addSubview(showActivityButton)

        // Add and activate constraints
        // As we discussed before, you can position the view by setting its frame, but because
        // here we want to use auto-layout, we need to tell the system to buzz off ;)
        showActivityButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showActivityButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showActivityButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -64)
        ])

        // Store the reference to thr button so we can change the title if view is animating
        self.showActivityButton = showActivityButton
    }

    func setupActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)

        activityIndicatorView.color = .red
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.stopAnimating()

        // Add button to as subview to our parent view
        view.addSubview(activityIndicatorView)

        // Add and activate constraints
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128)
        ])

        // Store the reference to the indicator view so we can show and hide animation on button press
        self.activityIndicatorView = activityIndicatorView
    }
}

// MARK: - Private action handlers

private extension ViewController {

    // As you might have noticed the keyword MARK, well it is used to create some sort of
    // separation in your code Press CONTROL + 6, and you should get popup on the top of the editor
    // with list (signatures) of all your functions here, and you should see your MARKS.

    // As I mentioned above, we are using ObjC runtime for this to work, so we need to
    // annontate the method so that the runtime can find it.
    @objc
    func showActivtiyIndicatorActionHandler(_ button: UIButton) {
        // If for some strange reason user is able to press button befoe UI is set we
        // need to check if activityIndicatorView exists (hence optional)
        // Or if we made a bug and we never set activityIndicatorView on ViewController
        guard let activityIndicatorView = activityIndicatorView else {
            return
        }

        if activityIndicatorView.isAnimating {
            activityIndicatorView.stopAnimating()
            // Second approach: without if-let/guard-let we could use Optional/nil Chaining where
            // we use `?` after Optional property - with this
            showActivityButton?.setTitle("Show Activity", for: .normal)
        } else {
            activityIndicatorView.startAnimating()
            showActivityButton?.setTitle("Hide Activity", for: .normal)
        }
    }
}
