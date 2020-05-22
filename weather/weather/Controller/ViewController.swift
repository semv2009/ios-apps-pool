//
//  ViewController.swift
//  weather
//
//  Created by Artyom Burkan on 14.05.2020.
//  Copyright © 2020 Artyom Burkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    let weatherFetcher = WeatherFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let city = textField.text {
            weatherFetcher.fetchCityWeather(at: city) { responseData in
                switch responseData {
                case .success(let weather):
                    print(weather)
                    DispatchQueue.main.async {
                        self.cityLabel.text = weather.name
                        self.temperatureLabel.text = weather.temperature
                    }
                case .failure(let error):
                    print("Error of weather request: \(error)")
                }
            }
        }
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text?.removeAll()
        print("end editing")
    }
}

