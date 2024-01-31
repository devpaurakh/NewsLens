//
//  NewsData.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 30/01/2024.
//

import Foundation
struct NewsData: Codable{
    let status: String
    let articles:[NewsList]
}
