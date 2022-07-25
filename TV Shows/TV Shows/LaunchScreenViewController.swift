//
//  LaunchScreenViewController.swift
//  TV Shows
//
//  Created by Infinum on 19.07.2022..
//

import UIKit

final class LaunchScreenViewController: UIViewController {
        
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI(){
        loginButton.layer.cornerRadius = 50
    }
    
    @IBAction func toggleRememberMe(_ sender: Any) {
    }
    

}
