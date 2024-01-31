//
//  NewsDetailViewController.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 30/01/2024.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet var newsContentDetail: UILabel!
    @IBOutlet var newsTitleDetail: UILabel!
    @IBOutlet var newImageDetail: UIImageView!
    var newsContent:NewsList = NewsList(author: "", title: "", urlToImage: "",  content: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTitleDetail.text = newsContent.title
        if newsContent.urlToImage != nil{
            let url = URL(string: newsContent.urlToImage!)
            newImageDetail.downloadImage(from: url!)
            newImageDetail.contentMode = .scaleAspectFill
        }
        else {
            newImageDetail.image = UIImage(named: "photo")
        }
        
        newsContentDetail.text = newsContent.content
    }
    

   

}
