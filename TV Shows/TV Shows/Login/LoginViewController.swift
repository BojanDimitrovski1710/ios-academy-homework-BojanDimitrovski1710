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
    
    private var counter: Int = 0
    private var cornerRadius: Int = 75
    private var user: UserResponse? = nil
    private var rememberUser = false
    
    // MARK: - Outlets

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailField: UITextField!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var rememberMeButton: UIButton!
    @IBOutlet private weak var infoLabel: UILabel!

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        cornerRadius = 75
        loginButton.layer.cornerRadius = CGFloat(cornerRadius)
        self.navigationController?.setToolbarHidden(true, animated: false)
        rememberMeButton.setTitle(" ", for: .normal)
        
        let decoder = PropertyListDecoder()
        if
            let data = UserDefaults.standard.data(forKey: "loginInfo"),
            let decodedLoginInfo = try? decoder.decode(LoginInfo.self, from: data)
        {
            self.emailField.text = decodedLoginInfo.email
            self.passwordField.text = decodedLoginInfo.password
        }
    }
    
    func remember(){
        let loginInfo = LoginInfo(email: self.emailField.text!, password: self.passwordField.text!)
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(loginInfo){
            UserDefaults.standard.set(encoded, forKey: "loginInfo")
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
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let userResponse):
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    if self.rememberUser {
                        self.remember()
                    }
                    self.handleSuccesfulLogin(for: userResponse.user, headers: headers)
                case .failure(let error):
                    print("Failure: \(error)")
                    let alert = UIAlertController(title: "Invalid Login", message: "Try Again", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
                    self.present(alert, animated: true, completion: nil)
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
                    if self.rememberUser{
                        self.remember()
                    }
                    self.user = response
                    let alert = UIAlertController(title: "Registration Succses", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
                    self.present(alert, animated: true, completion: nil)
                case .failure(let error):
                    print("Failure: \(error)")
                    let alert = UIAlertController(title: "Invalid Registration", message: "Try Again", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func handleSuccesfulLogin(for user: User, headers: [String: String]){
        guard let authInfo = try? AuthInfo(headers: headers) else{
            infoLabel.text = "Missing Headers"
            return
        }
        infoLabel.text = "\(user)\n\n\(authInfo)"
        let NewStoryboard = UIStoryboard(name: "Shows", bundle: nil)
        let ShowsViewController = NewStoryboard.instantiateViewController(withIdentifier: "ShowsViewController") as! ShowsViewController
        
        ShowsViewController.user = user
        ShowsViewController.authInfo = authInfo
        
        self.navigationController?.setViewControllers([ShowsViewController], animated: true)
    }
}
