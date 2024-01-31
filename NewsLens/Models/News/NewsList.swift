//
//  NewsList.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 30/01/2024.
//


import Foundation


// MARK: - Article
struct NewsList: Codable {
    let author: String?
    let title: String
    let urlToImage: String?
    let content: String?
}


