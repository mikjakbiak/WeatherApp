//
//  HourlyView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct HourlyView: View {
    @EnvironmentObject var weatherData: WeatherDataModel
    @State var locationString: String = "No location"

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            VStack {
                Text(locationString)
                    .font(.largeTitle)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                List {
                    ForEach(weatherData.forecast!.hourly) { hour in
                        HourCell(current: hour)
                        
                    }
                }.opacity(0.8)
            }
        }.onAppear {
            Task.init {
                self.locationString = await getLocFromLatLon(lat: weatherData.forecast!.lat, lon: weatherData.forecast!.lon)
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(WeatherDataModel())
    }
}
