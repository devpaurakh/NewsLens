//
//  OnBoardingCollectionViewCell.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 25/01/2024.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifire = String(describing: OnBoardingCollectionViewCell.self)
    
    @IBOutlet var slideDescLabel: UILabel!
    @IBOutlet var slideTitleLabel: UILabel!
    @IBOutlet var slideImage: UIImageView!
    
    
    
    func setup(_ slide: OnBoardingSlide){
        slideImage.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescLabel.text = slide.description
        
        
    }
}
