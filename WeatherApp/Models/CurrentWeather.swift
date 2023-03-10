//
//  Weather.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 12.02.2023.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let weatherDescription: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    let maxTemperature: Double
    var maxTemperatureString: String {
        return String(format: "%.0f", maxTemperature)
    }
    
    let minTemperature: Double
    var minTemperatureString: String {
        return String(format: "%.0f", minTemperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.1f", feelsLikeTemperature)
    }
    
    let currentVisibility: Int
    var currentVisibilityString: String {
        return String(currentVisibility / 1000)
    }
    
    let windSpeed: Double
    var windSpeedString: String {
        return String(format: "%.0f", windSpeed * 3.6)
    }
    
    let currentPressure: Int
    var currentPressureString: String {
        return String(currentPressure)
    }
    let currentHumidity: Int
    var currentHumidityString: String {
        return String(currentHumidity)
    }
    
    let conditionCode: Int
    var systemIconName: String { /// https://openweathermap.org/weather-conditions
        switch conditionCode {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default:
            return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        maxTemperature = currentWeatherData.main.tempMax
        minTemperature = currentWeatherData.main.tempMin
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
        weatherDescription = currentWeatherData.weather.first!.main
        currentVisibility = currentWeatherData.visibility
        currentHumidity = currentWeatherData.main.humidity
        currentPressure = currentWeatherData.main.pressure
        windSpeed = currentWeatherData.wind.speed
    }
}
