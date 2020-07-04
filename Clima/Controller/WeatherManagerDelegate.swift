//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Nawaf B Al sharqi on 13/11/1441 AH.
//  Copyright © 1441 Nawaf.com. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
   func didUpdateWeather(weather:WeatherModel)
}
