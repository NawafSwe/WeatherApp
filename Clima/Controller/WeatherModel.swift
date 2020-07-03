//
//  WeatherModel.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 12/11/1441 AH.
//  Copyright © 1441 Nawaf.com. All rights reserved.
//

import Foundation
struct WeatherModel {
    let conditionId: Int
    let cityName : String
    let temperature : Float
    
    
    //computed property
    var   conditionName : String {
        switch conditionId {
            case 200...231:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 700...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...884:
                return "cloud.blot"
            
            default:
                return "cloud"
        }
    }
    
    
    
    
}
