//
//  HourlyCellInfo.swift
//  weather_app
//
//  Created by Deny Vorko on 23.09.2022.
//

import Foundation

struct HourlyCellInfo {
    let time: String
    let imageName: String
    let temp: Int
    
    static let mock: [HourlyCellInfo] = [
        HourlyCellInfo(time: "Now", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "2 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "3 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "4 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "5 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "6 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "7 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "8 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "9 pm", imageName: "sunIcon", temp: 20),
        HourlyCellInfo(time: "10 pm", imageName: "sunIcon", temp: 20)
    ]
}
