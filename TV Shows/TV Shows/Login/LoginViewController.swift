//
//  LoginViewController.swift
//  TV Shows
//
//  Created by Infinum on 11.07.2022..
//



import UIKit
import Alamofire
import MBProgressHUD
final class LoginViewController: UIViewController {
    // MARK: - Properties
    
    private var cornerRadius: Int = 75
    private var rememberUser: Bool = false
    private var user: UserResponse? = nil
    
    // MARK: - Outlets
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var rememberMeButton: UIButton!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        cornerRadius = 75
        loginButton.layer.cornerRadius = CGFloat(cornerRadius)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func pushToHome(){
        let NewStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let HomeViewController = NewStoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(HomeViewController, animated: true)
    }
    
    func clearInfo(){
        if !rememberUser{
            emailField.text = nil
            passwordField.text = nil
        }
    }
    
    // MARK: - Actions
    
    @IBAction func toggleRememberMe(_ sender: Any) {
        if !rememberUser {
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .normal)
            rememberUser = true
        }else{
            rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
            rememberUser = false
        }
        
    }
    @IBAction func login(_ sender: Any) {
        if !emailField.text!.isEmpty && !passwordField.text!.isEmpty{
            MBProgressHUD.showAdded(to: self.view, animated: true)

            let parameters: [String: String] = [
                "email": emailField.text!,
                "password": passwordField.text!
            ]

            AF.request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate() // Status code in 200 ..< 300 range
            .responseDecodable(of: UserResponse.self) { [weak self] response in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch response.result {
                case .success(let response):
                    print("Success: \(response)")
                    self.clearInfo()
                    self.user = response
                    self.pushToHome()
                case .failure(let error):
                    print("Failure: \(error)")
                }
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        if !emailField.text!.isEmpty && !passwordField.text!.isEmpty{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters: [String: String] = [
                "email": emailField.text!,
                "password": passwordField.text!,
                "password_confirmation": passwordField.text!
            ]
            
            AF.request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate() // Status code in 200 ..< 300 range
            .responseDecodable(of: UserResponse.self) { [weak self] response in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch response.result {
                case .success(let response):
                    print("Success: \(response)")
                    self.clearInfo()
                    self.user = response
                    self.pushToHome()
                case .failure(let error):
                    print("Failure: \(error)")
                }
            }
            
        }
    }
}
