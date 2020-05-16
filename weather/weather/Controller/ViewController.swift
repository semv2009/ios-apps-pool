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
        print(textField.text ?? "Fail")
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text?.removeAll()
        print("end editing")
    }
}

