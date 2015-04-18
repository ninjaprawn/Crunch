//
//  CNFeedTableViewCell.swift
//  Crunch
//
//  Created by George Dan on 17/04/2015.
//  Copyright (c) 2015 Ninjaprawn. All rights reserved.
//

import UIKit

enum FeedType {
    case RSS
    case Twitter
    case Instagram
}

class CNFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.text = ""
        descriptionLabel.text = ""
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateImageForType(feedType: FeedType) {
        iconImage.layer.cornerRadius = 20
        iconImage.layer.masksToBounds = true
        switch feedType {
            case FeedType.RSS:
                self.iconImage.image = UIImage(named: "rss")
                break
            case FeedType.Twitter:
                self.iconImage.image = UIImage(named: "twitter")
                break
            case FeedType.Instagram:
                self.iconImage.image = UIImage(named: "instagram")
                break
            default:
                self.iconImage.image = UIImage(named: "rss")
                break
        }
    }
    
    func updateCellWith(text: String, description: String) {
        titleLabel.text = text
        descriptionLabel.text = description
    }
    
}
