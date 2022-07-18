//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 11.07.2022..
//



import UIKit
final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private var counter: Int = 0
    private var cornerRadius: Int = 75
    
    // MARK: - Outlets
    
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var changeAnimationButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateSpinner()
    }
    
    func setupUI(){
        cornerRadius = 75
        counterLabel.text = "0"
        incrementButton.layer.cornerRadius = CGFloat(cornerRadius)
        decrementButton.layer.cornerRadius = CGFloat(cornerRadius)
        resetButton.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func animateSpinner(){
        changeAnimation()
        let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false){
            timer in self.changeAnimation()
        }
    }
    
    // MARK: - Actions
    
    @IBAction @objc func changeAnimation(){
        if activityIndicator.isAnimating{
            activityIndicator.stopAnimating()
            changeAnimationButton.setTitle("Start", for: .normal)
        }else{
            activityIndicator.startAnimating()
            changeAnimationButton.setTitle("Stop", for: .normal)
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
