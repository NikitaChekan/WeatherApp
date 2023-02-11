//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 11.02.2023.
//

import Foundation

struct NetworkManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                
            }
        }
        task.resume()
    }
}
