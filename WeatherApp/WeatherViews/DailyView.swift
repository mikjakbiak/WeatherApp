//
//  DailyView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct DailyView: View {
    @EnvironmentObject var weatherData: WeatherDataModel
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Image("background2")
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
                    ForEach(weatherData.forecast!.daily) { day in
                        DayCell(day: day)
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

struct DailyView_Previews: PreviewProvider {
    static var previews: some View {
        DailyView().environmentObject(WeatherDataModel())
    }
}
