//
//  ShowInfoTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2022..
//

import UIKit

class ShowInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var reviewDetails: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingView.configure(withStyle: .large)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
