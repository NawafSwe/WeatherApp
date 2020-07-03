//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    //values
    var cityName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //its like making the searchTextField as a listener to any changes that it will announce it to the WeatherViewController
        searchTextField.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    //NOTE: the param textFiled is a reference for the searchTextField
    //this is to make the return key works
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //endEditing hide the keyboard
        searchTextField.endEditing(true)
        return true
    }
    //after ending the editing will clear the field
    func textFieldDidEndEditing(_ textField: UITextField) {
        //take the value here
        cityName = textField.text!
        textField.text = ""
        textField.placeholder = "search"
        
    }
    
    // checking if the user type or not to end editing or not
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "type city name please"
            return false
        }
    }
    
    
}

