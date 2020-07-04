//
//  weatherData.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 Nawaf.com. All rights reserved.
//

import Foundation

//filtering the data from the response
//Decodable is a protocol
//main is an object that holds the temp value so this is the way to extract data
struct WeatherData : Codable{
    let name : String
    let main: Main
    let weather : [Weather]
}

// we have to provide  it decodable protocol
//we have make the names matches the response
struct Main : Codable{
    let temp: Float
}

struct Weather :Codable{
    let id : Int
}




