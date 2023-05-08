//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Fork of CourseWork2Starter created by GirishALukka
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject var weatherData = WeatherDataModel()
    @StateObject var pollutionData = PollutionDataModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(weatherData)
                .environmentObject(pollutionData)
        }
    }
}
