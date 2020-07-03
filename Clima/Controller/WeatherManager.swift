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
            
            //creating closure
            let task = session.dataTask(with: url) { (data, response, error) in
                //handling the response and getting the data
                //checking an error if there is then quit from this method
                if error != nil{
                    print(error!)
                    return
                }
                // checking the data
                if let safeData = data {
                    //parsing the data to json object
                    //must include self. because we are inside a closure because swift get confused here 'rule inside any closure '
                    self.parseJSON(weatherData: safeData)
                }
            }
            //starting the task
            task.resume()
            
        }
    }
    func parseJSON(weatherData:Data){
        let decoder = JSONDecoder()
        //which is the WeatherData is decodable
        do{
            //trying to decode the data
            let decodedData =  try decoder.decode(WeatherData.self,from: weatherData)
            let id =   decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            var weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            
            
            
        }catch {
            print(error)
        }
    }
    
    
    
    
    
}
