//
//  WeatherViewController.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 App Brewery. All rights reserved.
//
//
//
import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    //declaring the weatherManager
    var weatherManager  = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //its like making the searchTextField as a listener to any changes that it will announce it to the WeatherViewController
        searchTextField.delegate = self
        weatherManager.delegate = self
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
    
    // checking if the user type or not to end editing or not
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            cityLabel.text = textField.text
            return true
        }else{
            textField.placeholder = "type city name please"
            return false
        }
    }
    
    //after ending the editing will clear the field
    func textFieldDidEndEditing(_ textField: UITextField) {
        //take the value here
        //and making sure that there is no nil
        if let cityName = textField.text{
            weatherManager.fetchWeather(cityName: cityName)
        }
        searchTextField.text = ""
        searchTextField.placeholder = "search"
        
    }
    
    // will listen for any fetching weather data
    func didUpdateWeather(_ weatherManager: WeatherManager ,  weather:WeatherModel){
        //waiting for the response
        DispatchQueue.main.async{
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            
            
        }
    }
    
    func didFailWithError(_ weatherManager: WeatherManager,error:Error!){
        print(error!)
        
        
    }
    
}

