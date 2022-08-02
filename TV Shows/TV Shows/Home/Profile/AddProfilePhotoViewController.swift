//
//  AddProfilePhotoViewController.swift
//  TV Shows
//
//  Created by Infinum on 02.08.2022..
//

import Foundation
import UIKit
final class AddProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var submitImageButton: UIButton!
    @IBOutlet weak var pickImageButton: UIButton!
    
    override func viewDidLoad() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        setupNav()
        setupUI()
        pickImage()
    }
    
    func pickImage(){
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setupUI(){
        let cornerRadius = 75
        submitImageButton.layer.cornerRadius = CGFloat(cornerRadius)
        pickImageButton.layer.cornerRadius = CGFloat(cornerRadius)
    }
    
    func setupNav(){
        self.navigationItem.title = "My Profile"
        let leftButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dismissProfileImagePicker))
        self.navigationItem.leftBarButtonItem = leftButton
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
        
    }
    
    @IBAction func pickImageButtonClicked(_ sender: Any) {
        pickImage()
    }
}
