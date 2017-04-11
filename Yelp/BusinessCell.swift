//
//  BusinessCell.swift
//  Yelp
//
//  Created by Janvier Wijaya on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var reviewCountLabel: UILabel!

    var business : Business! {
        didSet {
            nameLabel.text = business.name
            addressLabel.text = business.address
            thumbImageView.setImageWith(business.imageURL!)
            categoriesLabel.text = business.categories
            distanceLabel.text = business.distance
            ratingImageView.setImageWith(business.ratingImageURL!)
            reviewCountLabel.text = "\(business.reviewCount!) Reviews"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        thumbImageView.clipsToBounds = true
        thumbImageView.layer.cornerRadius = 3
    }
}
