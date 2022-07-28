//
//  ReviewTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2022..
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var reviewComment: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
