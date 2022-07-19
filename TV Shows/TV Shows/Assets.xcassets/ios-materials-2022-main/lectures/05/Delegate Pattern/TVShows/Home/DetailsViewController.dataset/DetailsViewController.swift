import UIKit

/// Use this delegate in order to be notified when the user enables/disables dark mode. The `didEnableDarkMode(_:)` method
/// will be called as the user toggles through the ON/OFF, and it will carry the state as a `Bool` parameter.
protocol DetailsViewControllerDelegate: AnyObject {
    func didEnableDarkMode(_ enabled: Bool)
}

final class DetailsViewController: UIViewController {

    // MARK: - Delegate

    // Here we will add reference to whomever wants to listen
    // Delegate are usually 1 to 1 communication, e.g. it can only
    // store reference to one object. By making our property of type
    // `DetailsViewControllerDelegate` we are hiding implementation
    // details of the receiver, in our case `HomeViewController`

    // Also we are making loosely coupled components, which is what you usually want
    // We could make our property of type `HomeViewController` but that would create tight coupling

    // Another thing to note, when creating delegate pattern, you always want to use "weak" as property modifier
    weak var delegate: DetailsViewControllerDelegate?

    // MARK: - UI
    
    @IBOutlet
    private weak var darkModeSwitch: UISwitch! {
        didSet {
            darkModeSwitch.isOn = loadState()
        }
    }
}

// MARK: - Action
private extension DetailsViewController {

    @IBAction
    func switchActionHandler(_ sender: UISwitch) {
        // We are calling our "delegate" and function that it implements
        // If you noticed that ? after `delegate`, this is Swift language
        // construct and it is called "optional chaining"
        // Meaning that if you chain multiple stuff, and in that chain something
        // fails (nil), everything after it will not get called.
        delegate?.didEnableDarkMode(sender.isOn)

        // Here we are using our helper functions to save current state to `UserDefaults`
        // Why? Well this view controller will get destroyed once we go back to
        // previous screen, so the next time, if we don't restore the
        // the last known value, we ill have default (incorrect) state.
        saveState(state: sender.isOn)
    }

}

// MARK: - Load/Save
private extension DetailsViewController {

    func loadState() -> Bool {
        // As `UserDefaults` is stringly based API, which is a bit yuck, we are
        // storing our string key as constant so that we reduce the possibility of error.
        let isEnabled = UserDefaults.standard.bool(
            forKey: Constants.Defaults.switchStateKey.rawValue
        )
        return isEnabled
    }

    func saveState(state: Bool) {
        UserDefaults.standard.set(state, forKey: Constants.Defaults.switchStateKey.rawValue)
    }
}
