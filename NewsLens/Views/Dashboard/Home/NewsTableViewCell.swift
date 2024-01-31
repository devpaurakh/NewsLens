//
//  NewsTableViewCell.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 30/01/2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var newsAuther: UILabel!
    @IBOutlet var newsTitle: UILabel!
    @IBOutlet var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() 
    {
        super.prepareForReuse()
        
        newsImage.image = nil
    }

}
