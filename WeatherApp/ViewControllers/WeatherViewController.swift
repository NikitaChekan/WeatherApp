//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 11.02.2023.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTemperatureLabel: UILabel!
    @IBOutlet var weatherDescriptionLabel: UILabel!
    @IBOutlet var maximumTemperatureLabel: UILabel!
    @IBOutlet var minimumTemperatureLabel: UILabel!
    @IBOutlet var visibilityLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    
    var weatherManager = NetworkManager()
    
//    var status = CLAuthorizationStatus.notDetermined
    lazy var locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyHundredMeters
        location.requestWhenInUseAuthorization()
//        if status == .notDetermined {
//            location.requestWhenInUseAuthorization()
//         }
        return location
    }()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(
            withTitle: "Enter city name:",
            message: nil,
            style: .alert
        ) { [unowned self] city in
            self.weatherManager.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(weather: currentWeather)
        }
        updateLocation()
        
    }
    
    func updateInterface(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.weatherDescriptionLabel.text = weather.weatherDescription
            self.maximumTemperatureLabel.text = weather.maxTemperatureString
            self.minimumTemperatureLabel.text = weather.minTemperatureString
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTemperatureLabel.text = weather.feelsLikeTemperatureString
            self.visibilityLabel.text = weather.currentVisibilityString
            self.humidityLabel.text = weather.currentHumidityString
            self.pressureLabel.text = weather.currentPressureString
            self.windSpeedLabel.text = weather.windSpeedString
            
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconName)
        }
    }
    
    func updateLocation() {
//        DispatchQueue.main.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestLocation()
            }
//        }
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.status = manager.requestWhenInUseAuthorization()
//    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        weatherManager.fetchCurrentWeather(forRequestType: .coordinate(
            latitude: latitude,
            longitude: longitude
        ))
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
