//
//  LoginViewController.swift
//  TVShows
//
//  Copyright © 2022 Filip Gulan. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // registerUserWith(email: "filip.gulan+28@infinum.hr", password: "infinum1")
        // alamofireCodableRegisterUserWith(email: "filip.gulan+4@infinum.hr", password: "infinum1")
        loginUserWith(email: "filip.gulan@infinum.hr", password: "infinum1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - Register + manual JSON parsing

private extension LoginViewController {

    func registerUserWith(email: String, password: String) {
        MBProgressHUD.showAdded(to: view, animated: true)

        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseJSON { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let response):
                    guard
                        let jsonDict = response as? Dictionary<String, Any>,
                        let dataDict = jsonDict["user"],
                        let dataBinary = try? JSONSerialization.data(withJSONObject: dataDict)
                    else { return }
                    do {
                        let user = try JSONDecoder().decode(User.self, from: dataBinary)
                        self.infoLabel.text = "Success: \(user)"
                    } catch let error {
                        self.infoLabel.text = "Serialization error: \(error)"
                    }
                case .failure(let error):
                    self.infoLabel.text = "API failure: \(error)"
                }
            }
    }
}

// MARK: - Register + automatic JSON parsing

private extension LoginViewController {

    func alamofireCodableRegisterUserWith(email: String, password: String) {
        MBProgressHUD.showAdded(to: view, animated: true)

        let parameters: [String: String] = [
            "email": email,
            "password": password,
            "password_confirmation": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let user):
                    self.infoLabel.text = "Success: \(user)"
                case .failure(let error):
                    self.infoLabel.text = "API/Serialization failure: \(error)"
                }
            }
    }

}

// MARK: - Login + automatic JSON parsing

private extension LoginViewController {

    func loginUserWith(email: String, password: String) {
        MBProgressHUD.showAdded(to: view, animated: true)

        let parameters: [String: String] = [
            "email": email,
            "password": password
        ]

        AF
            .request(
                "https://tv-shows.infinum.academy/users/sign_in",
                method: .post,
                parameters: parameters,
                encoder: JSONParameterEncoder.default
            )
            .validate()
            .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let userResponse):
                    let headers = dataResponse.response?.headers.dictionary ?? [:]
                    self.handleSuccesfulLogin(for: userResponse.user, headers: headers)
                case .failure(let error):
                    self.infoLabel.text = "API/Serialization failure: \(error)"
                }
            }
    }

    // Headers will be used for subsequent authorization on next requests
    func handleSuccesfulLogin(for user: User, headers: [String: String]) {
        guard let authInfo = try? AuthInfo(headers: headers) else {
            infoLabel.text = "Missing headers"
            return
        }
        infoLabel.text = "\(user)\n\n\(authInfo)"
    }
}
