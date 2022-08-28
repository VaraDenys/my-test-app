//
//  OpenWeaterAPI.swift
//  weather_app
//
//  Created by Deny Vorko on 28.08.2022.
//

import Foundation
import Alamofire

class OpenWeaterAPI {
    static let apiEndpoint = "https://api.openweathermap.org/data/2.5/weather?lat=47&lon=35&appid=580ce1425a928abcc337271eedd85c6f&units=metric"
    static let apiKey = "580ce1425a928abcc337271eedd85c6f"
    
    static func getWeatherInfo() {
        guard let url = URL(string: apiEndpoint),
              let request = try? URLRequest(url: url, method: .get) else {
            return
        }
        
        AF.request(apiEndpoint).response { response in
            
        }
    }
}
