//
//  Constants.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 03/03/26.
//

import Foundation

enum Constant {
    static let apiKey = "bc2163a9ea372eb0c3a4a4cded2a30e0"
}

enum ErrorType: String,Error {
    case invalidURL = "URL is incorrect"
    case invalidResponse = "Invalid Response"
    case invalidData = "Unable to fetch the weather data"
}
