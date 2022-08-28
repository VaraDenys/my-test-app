//
//  WeatherInfo.swift
//  weather_app
//
//  Created by Deny Vorko on 28.08.2022.
//

import Foundation

struct HeaderWeatherInfo {
    let title: String
    let value: String
    
    static func someInfo() -> [HeaderWeatherInfo] {
        return [
            HeaderWeatherInfo.init(title: "First", value: "22 km/h"),
            HeaderWeatherInfo.init(title: "Second", value: "22 km/h"),
            HeaderWeatherInfo.init(title: "Third", value: "22 km/h"),
            HeaderWeatherInfo.init(title: "Fourth", value: "22 km/h")
        ]
    }
}
