//
//  WeatherManager.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 Nawaf.com. All rights reserved.
//

import Foundation

// protocols are created in the same file where we fetch and manage data
protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager ,  weather:WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager,error:Error!)
}

struct WeatherManager{
    let weatherUrl : String = "https://api.openweathermap.org/data/2.5/weather?&appid=7e19aa0f2eca89b3f129abfeec80c8d2&units=metric"
    // using the delegate design pattern
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName:String){
        let urlString:String = "\(self.weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
        
    }
    
    //using with make more sense
    func performRequest(with urlString:String){
        //to make sure there is no nil
        if let url = URL(string: urlString){
            // creating URL session
            let session = URLSession(configuration: .default)
            
            //give the session a task
            //completionHandler like callbacks if there is a problem or delays
            //completion handler will be called after the task is finished
            //after that we will be able to access the data and the response and the error
            
            //creating closure
            let task = session.dataTask(with: url) { (data, response, error)  in
                //handling the response and getting the data
                //checking an error if there is then quit from this method
                if error != nil{
                    self.delegate?.didFailWithError(self,error: error!)
                    return
                }
                // checking the data
                if let safeData = data {
                    //parsing the data to json object
                    //must include self. because we are inside a closure because swift get confused here 'rule inside any closure '
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            //starting the task
            task.resume()
        }
    }
    
    //to be able to return nil we put -> returnType!
    func parseJSON(_ weatherData:Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        //which is the WeatherData is decodable
        
        do{
            //trying to decode the data
            let decodedData =  try decoder.decode(WeatherData.self,from: weatherData)
            let id =   decodedData.weather[0].id
            let temp = decodedData.main.temp
            let  name = decodedData.name
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weatherModel
            
        }catch {
            self.delegate?.didFailWithError(self,error: error)
            return nil
        }
        
    }
    
    
}
