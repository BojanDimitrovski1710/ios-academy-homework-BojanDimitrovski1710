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
    private var userResponse: UserResponse? = nil
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
    }
    
    func remember(AuthInfo: AuthInfo, User: User){
        let encoder = PropertyListEncoder()
        if let encoded = try? encoder.encode(AuthInfo){
           UserDefaults.standard.set(encoded, forKey: "AuthInfo")
        }
        if let encoded2 = try? encoder.encode(User){
            UserDefaults.standard.set(encoded2, forKey: "User")
        }
    }
    
    func shakeField(field: UITextField){
        let animation =  CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: field.center.x - 5, y: field.center.y - 5 ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: field.center.x + 5, y: field.center.y + 5 ))
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor(red: 100, green: 0, blue: 0, alpha: 1).cgColor
        field.layer.add(animation, forKey: "position")
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
    
    @IBAction func revertEmailToNormal(_ sender: Any) {
        emailField.layer.borderWidth = 0
    }
    
    @IBAction func revertPasswordToNormal(_ sender: Any){
        passwordField.layer.borderWidth = 0
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
                case .success(let response):
                    self.userResponse = response
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    self.handleSuccesfulLogin(for: response.user, headers: headers)
                case .failure(let error):
                    print("Failure: \(error)")
                    self.shakeField(field: self.emailField)
                    self.shakeField(field: self.passwordField)
                    let alert = UIAlertController(title: "Invalid Login", message: "Invalid Credentials", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
                    self.present(alert, animated: true, completion: nil)
                     
                }
            }
        }else{
            if emailField.text!.isEmpty{
                self.shakeField(field: emailField)
            }
            if passwordField.text!.isEmpty{
                self.shakeField(field: passwordField)
            }
            let alert = UIAlertController(title: "Invalid Login", message: "All fields must be filled in", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true, completion: nil)
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
                    self.userResponse = response
                    let alert = UIAlertController(title: "Registration Succses", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
                    self.present(alert, animated: true, completion: nil)
                case .failure(let error):
                    print("Failure: \(error)")
                    self.shakeField(field: self.emailField)
                    self.shakeField(field: self.passwordField)
                    let alert = UIAlertController(title: "Invalid Registration", message: "Invalid Credentials", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            if emailField.text!.isEmpty{
                self.shakeField(field: emailField)
            }
            if passwordField.text!.isEmpty{
                self.shakeField(field: passwordField)
            }
            let alert = UIAlertController(title: "Invalid Registration", message: "All fields must be filled in", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func handleSuccesfulLogin(for user: User, headers: [String: String]){
        guard let authInfo = try? AuthInfo(headers: headers) else{
            infoLabel.text = "Missing Headers"
            return
        }
        if self.rememberUser{
            self.remember(AuthInfo: authInfo, User: self.userResponse!.user)
        }
        let NewStoryboard = UIStoryboard(name: "Shows", bundle: nil)
        let ShowsViewController = NewStoryboard.instantiateViewController(withIdentifier: "ShowsViewController") as! ShowsViewController
        
        ShowsViewController.user = user
        ShowsViewController.authInfo = authInfo
        
        self.navigationController?.setViewControllers([ShowsViewController], animated: true)
    }
}
