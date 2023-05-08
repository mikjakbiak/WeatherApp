//
//  Navbar.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct Navbar: View {
    
    var body: some View {
        TabView{
           HomeView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("City")
                }
            DetailedWeatherView()
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("Weather Now")
                }
            HourlyView()
                .tabItem{
                    Image(systemName: "clock.fill")
                    Text("Hourly Summary")
                }
            DailyView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Forecast")
                }
            PollutionView()
                .tabItem {
                    Image(systemName: "exclamationmark.icloud.fill")
                    Text("Pollution")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

