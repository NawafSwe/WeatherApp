//
//  WeatherViewController.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 App Brewery. All rights reserved.
//
//
//
import CoreLocation
import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    //declaring the weatherManager
    var weatherManager  = WeatherManager()
    let locationManager = CLLocationManager()
    var lon : Double!
    var lat : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //its like making the searchTextField as a listener to any changes that it will announce it to the WeatherViewController
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        //before requesting the location we have to set the delegate
        locationManager.delegate = self
        
        //request from the user and take a permission
        locationManager.requestWhenInUseAuthorization()
        //requesting the location after taking the permission
        locationManager.requestLocation()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    // if user want to return to his weather current location 
    @IBAction func locationButton(_ sender: UIButton) {
        weatherManager.fetchWeatherByLocation(latitude: lat, longitude: lon)
    }
    
    
    
}


// MARK:- UITextFieldDelegate
// a way to refactor and using the separation of concerns
//Note: UITextFieldDelegate methods are optionals which has a default behavior
extension WeatherViewController : UITextFieldDelegate{
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
            weatherManager.fetchWeatherByCityName(cityName: cityName)
        }
        searchTextField.text = ""
        searchTextField.placeholder = "search"
        
    }
    
}


// MARK:- WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate{
    // will listen for any fetching weather data
    func didUpdateWeather(_ weatherManager: WeatherManager ,  weather:WeatherModel){
        //waiting for the response
        DispatchQueue.main.async{
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
        }
    }
    func didFailWithError(_ weatherManager: WeatherManager,error:Error!){
        print(error!)
        
        
    }
    
}

//MARK:- CLLocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        // getting the last location which is the most accurate one
        if let location = locations.last{
            //example of the output <+37.78583400,-122.40641700> +/- 5.00m (speed -1.00 mps / course -1.00) @ 7/4/20, 4:20:56 PM Arabian Standard Time
            //we can from here fetching the current city name and the weather from this data by using longitude and latitude
            //CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417) by using location.coordinate
            //next we will fetch the weather data for the current location of the user
             lat = location.coordinate.latitude
             lon = location.coordinate.longitude
            
            
            //it will trigger the didWeatherUpdate and will fetch the data and displayIt first
            weatherManager.fetchWeatherByLocation(latitude:lat, longitude: lon)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error.localizedDescription)")
    }
    
}


