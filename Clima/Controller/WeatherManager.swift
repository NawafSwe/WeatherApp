//
//  WeatherManager.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 Nawaf.com. All rights reserved.
//

import Foundation

struct WeatherManager{
    let weatherUrl : String = "api.openweathermap.org/data/2.5/weather?&appid=7e19aa0f2eca89b3f129abfeec80c8d2&units=metric"
    
    
    func fetchWeather(cityName:String){
        let urlString:String = "\(self.weatherUrl)&q=\(cityName)"
        print(urlString)
        
    }
}
