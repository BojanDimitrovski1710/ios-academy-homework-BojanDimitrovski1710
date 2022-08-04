//
//  AddProfilePhotoViewController.swift
//  TV Shows
//
//  Created by Infinum on 02.08.2022..
//

import Foundation
import UIKit
import Alamofire
import MBProgressHUD
final class AddProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    public var authInfo: AuthInfo!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitImageButton: UIButton!
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        setupNav()
        setupUI()
        
    }
    
    func setupNav(){
        self.navigationItem.title = "Change Profile Photo"
        let leftButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dismissProfileImagePicker))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        //pickImage()
    }
    
    func pickImage(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setupUI(){
        let cornerRadius = 75
        submitImageButton.layer.cornerRadius = CGFloat(cornerRadius)
        pickImageButton.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    
    
    func shakeButton(button: UIButton){
        let animation =  CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: button.center.x - 5, y: button.center.y - 5 ))
        animation.toValue = NSValue(cgPoint: CGPoint(x: button.center.x + 5, y: button.center.y + 5 ))
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 0
        button.layer.borderColor = UIColor(red: 100, green: 0, blue: 0, alpha: 1).cgColor
        button.layer.add(animation, forKey: "position")
    }
    
    @objc func dismissProfileImagePicker(){
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageView.contentMode = .scaleAspectFit
                imageView.image = pickedImage
            }

            dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitImage(_ sender: Any) {
        
        if self.imageView.image == nil {
            self.shakeButton(button: self.pickImageButton)
            let alert = UIAlertController(title: "Invalid Submisson", message: "Please choose a picture before submitting", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            guard let imageData = self.imageView.image!.jpegData(compressionQuality: 0.9)
                else { return }

                let requestData = MultipartFormData()
                requestData.append(
                    imageData,
                    withName: "image",
                    fileName: "image.jpg",
                    mimeType: "image/jpg"
                )

                AF
                    .upload(
                        multipartFormData: requestData,
                        to: "https://tv-shows.infinum.academy/users", method: .put,
                        headers: HTTPHeaders(authInfo.headers)
                    )
                    .validate()
                    .responseDecodable(of: UserResponse.self) { dataResponse in
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "didChangeImage"), object: nil)
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.dismissProfileImagePicker()
                    }
        }
        
    }
    
    @IBAction func pickImageButtonClicked(_ sender: Any) {
        self.pickImageButton.layer.borderWidth = 0
        pickImage()
    }
}
