//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 11.07.2022..
//

var counter = 0

import UIKit
class LoginViewController: UIViewController {
    
    @IBOutlet weak var counterLbl: UILabel!
    @IBOutlet weak var incrementBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0
        counterLbl.text = " "
        print("Test")
    }
    
    @IBAction func touchIncrement(){
        print("Whats Up?")
        counter += 1
        print(counter)
        counterLbl.text = String(counter)
    }
    
    @IBAction func touchDecrement(){
        print("Whats Down?")
        counter -= 1
        print(counter)
        counterLbl.text = String(counter)
    }
    
    @IBAction func touchReset(){
        print("Whats Back At The Start?")
        counter = 0
        print(counter)
        counterLbl.text = String(counter)
    }
}
