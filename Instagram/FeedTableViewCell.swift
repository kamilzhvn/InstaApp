//
//  FeedTableViewCell.swift
//  Instagram
//
//  Created by macbook on 7/17/19.
//  Copyright © 2019 Robert Percival. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet var userInfo: UILabel!
    @IBOutlet var comment: UILabel!
    @IBOutlet var postedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
