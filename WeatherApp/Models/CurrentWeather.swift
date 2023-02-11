//
//  Weather.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 11.02.2023.
//

import Foundation

struct CurrentWeather {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

struct Weather {
    let id: Int
}
