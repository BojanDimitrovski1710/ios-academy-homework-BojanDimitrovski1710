//
//  ViewController_C.swift
//  Navigation
//

import UIKit

class ViewController_C: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - IBActions -
    
    @IBAction func didSelectDoneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didSelectPushButton(_ sender: Any) {
        // We need to instantiate the Storyboard in which our view controller that we want to go to lives
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // We need to instantiate the view controller that we want to go to
        let viewControllerD = storyboard.instantiateViewController(withIdentifier: "ViewController_D") as! ViewController_D
        
        viewControllerD.name = "iOS Academy"
        // We need to push that view controller on top of the navigation stack
        navigationController?.pushViewController(viewControllerD, animated: true)
    }
}
