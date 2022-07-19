import UIKit

final class HomeViewController: UIViewController {

     override func viewDidLoad() {
        super.viewDidLoad()
        // Your code goes here bellow ....
     }
}

// MARK: - Navigation

private extension HomeViewController {

    @IBAction
    func showDetailsActionHandler() {
        let storyboard = UIStoryboard(name: "Home", bundle: .main)
        let detailsViewController = storyboard.instantiateViewController(
            withIdentifier: String(describing: DetailsViewController.self)
        ) as! DetailsViewController

        // Setting us, home view controller, as delegate to details view controller
        // aka. details view controller will notify us when it modifies something
        // aka. it will delegate it to us.
        detailsViewController.delegate = self

        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

//MARK: - DetailsViewControllerDelegate

// Here we are saying that our class can be delegate for `DetailsViewController`
// We are extending our class with conformance to `DetailsViewControllerDelegate` protocol
// Meaning that `DetailsViewController` will not know anything about us,
// only that we can respond to function in protocol `didEnableDarkMode`
// Delegate implementation are usually done with protocols (interfaces)
extension HomeViewController: DetailsViewControllerDelegate {

    func didEnableDarkMode(_ enabled: Bool) {
        view.backgroundColor = enabled ? .black : .white
    }
}
