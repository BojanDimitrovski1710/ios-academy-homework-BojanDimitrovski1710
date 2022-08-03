//
//  ProfileViewController.swift
//  TV Shows
//
//  Created by Infinum on 01.08.2022..
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD
final class ProfileViewController: UIViewController{
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    
    public var authInfo: AuthInfo!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUser()
        setupNav()
        setupNotifications()
    }
    
    @objc func dismissProfile(){
        dismiss(animated: true)
    }
    
    func setupNav(){
        self.navigationItem.title = "My Account"
        let leftButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dismissProfile))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    func getUser(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request(
            "https://tv-shows.infinum.academy/users/me",
            method: .get,
            headers: HTTPHeaders(self.authInfo.headers)
        )
        .validate()
        .responseDecodable(of: UserResponse.self) { [weak self] dataResponse in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch dataResponse.result {
                case .success(let response):
                    
                    self.userEmail.text = response.user.email
                    let url = URL(string: response.user.imageUrl ?? "")
                    self.userImage.kf.setImage(with: url, placeholder: UIImage(named: "ic-profile-placeholder"))
                    print(response.user)
                    break
                case .failure(let error):
                    print("Failure: \(error)")
                    break
                }
        }
    }
    
    func setupNotifications(){
        NotificationCenter
            .default
            .addObserver(forName: Notification.Name(rawValue: "didChangeImage"), object: nil, queue: nil) { notification in
                self.getUser()
            }
    }
    
    @IBAction func changeUserImage(_ sender: Any) {
        // TODO: Implement change image
        let newStoryboard = UIStoryboard(name: "AddProfilePhoto", bundle: nil)
        let AddProfilePhotoViewController = newStoryboard.instantiateViewController(withIdentifier: "AddProfilePhoto") as! AddProfileViewController
        AddProfilePhotoViewController.authInfo = self.authInfo
        present(AddProfilePhotoViewController, animated: true)
    }
    
    @IBAction func logOut(_ sender: Any) {
        dismiss(animated: true) {
            let decoder = PropertyListDecoder()
            let data = UserDefaults.standard.data(forKey: "AuthInfo")
            if data != nil{
                UserDefaults.standard.removeObject(forKey: "AuthInfo")
                UserDefaults.standard.removeObject(forKey: "User")
            }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "didLogout"), object: nil)

            // TODO: Implement log out
            
        }
    }
}
