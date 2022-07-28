//
//  ShowInfoTableViewCell.swift
//  TV Shows
//
//  Created by Infinum on 28.07.2022..
//

import UIKit

class ShowInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var showTitle: UILabel!
    
    @IBOutlet weak var showDescription: UILabel!
    @IBOutlet weak var reviewDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
