//
//  Weather.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 11.02.2023.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let tempMax: Double
    let tempMin: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMax = "temp_max"
        case tempMin = "temp_min"
        case feelsLike = "feels_like"
    }
}

struct Weather: Codable {
    let id: Int
    let description: String
}
