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
        ) { [unowned self] city in
            self.weatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(weather: currentWeather)
        }
        
        weatherManager.fetchCurrentWeather(forCity: "London")
    }
    
    func updateInterface(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconName)
        }
    }
}

