//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 11.02.2023.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    
    var weatherManager = NetworkManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(
            withTitle: "Enter city name",
            message: nil,
            style: .alert
        ) { city in
            self.weatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        weatherManager.fetchCurrentWeather(forCity: "London")
    }
    
}

extension WeatherViewController: NetworkManagerDelegate {
    func updateInterface(_: NetworkManager, with currentWeather: CurrentWeather) {
        self.cityLabel.text = currentWeather.cityName
        self.temperatureLabel.text = currentWeather.temperatureString
        self.feelsLikeTemperatureLabel.text = currentWeather.feelsLikeTemperatureString
    }
}

