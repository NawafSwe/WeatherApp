//
//  WeatherManager.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 Nawaf.com. All rights reserved.
//

import Foundation

struct WeatherManager{
    let weatherUrl : String = "https://api.openweathermap.org/data/2.5/weather?&appid=7e19aa0f2eca89b3f129abfeec80c8d2&units=metric"
    
    
    func fetchWeather(cityName:String){
        let urlString:String = "\(self.weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString:String){
        //to make sure there is no nil
        if let url = URL(string: urlString){
            // creating URL session
            let session = URLSession(configuration: .default)
            
            //give the session a task
            //completionHandler like callbacks if there is a problem or delays
            //completion handler will be called after the task is finished
            //after that we will be able to access the data and the response and the error
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //starting the task
            task.resume()
            
        }
    }
    
    //handling the response and getting the data
    func handle(data:Data? , response:URLResponse?, error:Error?){
        //checking an error if there is then quit from this method
        if error != nil{
            print(error!)
            return
        }
        // checking the data
        if let safeData = data {
            //converting the data to string using .utf8 encoding
            let dataString = String(data: safeData, encoding:.utf8)
            print(dataString ?? "no data")
        }
        
            
        
        
        
    }
    
}
