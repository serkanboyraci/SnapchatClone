//
//  FeedCell.swift
//  SnapchatClone
//
//  Created by Ali serkan Boyracı  on 12.12.2022.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet var feedUserNameLabel: UILabel!
    @IBOutlet var feedImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
