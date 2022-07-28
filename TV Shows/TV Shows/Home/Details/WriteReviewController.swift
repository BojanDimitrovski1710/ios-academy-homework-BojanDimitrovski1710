//
//  WriteReviewController.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2022..
//

import UIKit

class WriteReviewViewController: UIViewController {

    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var commentField: UITextField!
    
    public var show: Show!
    public var user: User!
    public var authInfo: AuthInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension WriteReviewViewController: RatingViewDelegate{
    func didChangeRating(_ rating: Int) {
        
    }
    
    
}
