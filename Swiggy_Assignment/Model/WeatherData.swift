//
//  Weather.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 03/03/26.
//

import Foundation

struct WeatherData: Decodable {
    let coord: Coord
    let main: Main
    let name: String
    let weather: [Weather]
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
    let pressure: Int
}

struct Weather: Decodable {
    let description: String
    let icon: String
}

