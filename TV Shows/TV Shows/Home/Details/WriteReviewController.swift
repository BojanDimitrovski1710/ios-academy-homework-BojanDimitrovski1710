//
//  WriteReviewController.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2022..
//

import UIKit
import Alamofire
import MBProgressHUD

class WriteReviewViewController: UIViewController {

    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var commentField: UITextField!
    
    public var show: Show!
    public var user: User!
    public var authInfo: AuthInfo!
    private var rating = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        ratingView.delegate = self
    }
    
    @objc func dismissReview(){
        dismiss(animated: true)
    }
    
    func setUpNav(){
        self.navigationItem.title = "Write a Review"
        let leftButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.dismissReview))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    @IBAction func submitReview(_ sender: Any) {
        self.didChangeRating(self.ratingView.rating)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let parameters: [String: String] = [
            "rating": String(self.rating),
            "comment": self.commentField.text!,
            "show_id": String(self.show.id)
            ]

        print(parameters)
        AF.request(
            "https://tv-shows.infinum.academy/reviews",
            method: .post,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: HTTPHeaders(authInfo.headers)
        )
        .validate()
        .responseDecodable(of: ReviewResponse.self) { [weak self] response in
                guard let self = self else { return }
                MBProgressHUD.hide(for: self.view, animated: true)
                switch response.result {
                case .success(let response):
                    print("Success: \(response)")
                    break
                case .failure(let error):
                    print("Failure: \(error)")
                    break
                }
            }
        self.dismissReview()

    }
    
}

extension WriteReviewViewController: RatingViewDelegate{
    func didChangeRating(_ rating: Int) {
        self.rating = rating
    }
    
    
}
