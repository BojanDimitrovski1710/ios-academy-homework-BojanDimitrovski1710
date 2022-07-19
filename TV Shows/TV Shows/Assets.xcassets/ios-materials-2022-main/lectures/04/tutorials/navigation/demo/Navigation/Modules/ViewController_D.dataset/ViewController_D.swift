//
//  ViewController_D.swift
//  Navigation
//

import UIKit

class ViewController_D: UIViewController {

    var name: String?
    
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoLabel.text = name
    }
}
