//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct DayCell: View {
    var day : Daily
   
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(day.weather[0].icon).png")) {image in
                    image.image?.resizable()
                }
            .frame(width: 80, height: 80)
            .shadow(color: .black, radius: 0.5)
            
            Spacer()
            
            VStack {
                Text(day.weather[0].weatherDescription.rawValue.capitalized)
                .font(.title3)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(day.dt))))
                    .formatted(.dateTime.weekday(.wide).day(.twoDigits)))
                .font(.title3)
            }
            
            Spacer()
            
            Text("\((Int)(day.temp.max))ºC / \((Int)(day.temp.min))ºC")
                .font(.title3)
            
        }
    }
    
}

struct DayCell_Previews: PreviewProvider {
    static var day = WeatherDataModel().forecast!.daily
    
    static var previews: some View {
        DayCell(day: day[0])
    }
}
