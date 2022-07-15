//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 11.07.2022..
//



import UIKit
class LoginViewController: UIViewController {
    var counter = 0
    var cornerRadius = 75
    var isAnimating = false
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 0
        cornerRadius = 75
        counterLabel.text = "0"
        incrementButton.layer.cornerRadius = CGFloat(cornerRadius)
        decrementButton.layer.cornerRadius = CGFloat(cornerRadius)
        resetButton.layer.cornerRadius = CGFloat(cornerRadius)
        
        startAnimation()
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false){
            timer in self.stopAnimation()
        }
        
    }
    
    @IBAction @objc func startAnimation(){
        if(!isAnimating){
            activityIndicator.startAnimating()
            isAnimating = true
        }
    }
    
    @IBAction @objc func stopAnimation(){
        if(isAnimating){
            activityIndicator.stopAnimating()
            isAnimating = false
        }
    }
    
    @IBAction func touchIncrement(){
        counter += 1
        counterLabel.text = String(counter)
    }
    
    @IBAction func touchDecrement(){
        counter -= 1
        counterLabel.text = String(counter)
    }
    
    @IBAction func touchReset(){
        counter = 0
        counterLabel.text = String(counter)
    }
}
