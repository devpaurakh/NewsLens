//
//  Handler Constant.swift
//  NewsLens
//
//  Created by Paurakh Vikram Saud on 28/01/2024.
//

import Foundation

class Handler_Constant{
    
    // Enum to represent custom API errors
    enum APIError: Error {
        case custom(message: String)
    }

    // Typealias for API response handler
    typealias Handler = (Result<Any?, APIError>) -> Void

    
}
