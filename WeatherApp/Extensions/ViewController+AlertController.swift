//
//  ViewController+AlertController.swift
//  WeatherApp
//
//  Created by Nikita Chekan on 11.02.2023.
//

import UIKit

extension WeatherViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { value in
            let cities = ["Gomel", "Moscow", "Minsk", "Toronto", "Saint Petersburg"]
            value.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                print("search info for the \(cityName)")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
}
