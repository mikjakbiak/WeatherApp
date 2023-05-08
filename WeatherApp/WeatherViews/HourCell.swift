//
//  HourCondition.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct HourCell: View {
    var current : Current
    
    var body: some View {
        HStack {
            VStack {
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt))))
                    .formatted(.dateTime.hour(.twoDigits(amPM: .abbreviated))))
                .font(.title3)
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(current.dt))))
                    .formatted(.dateTime.weekday()))
                .font(.title3)
            }
            
            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(current.weather[0].icon).png")) {image in
                    image.image?.resizable()
                }
            .frame(width: 80, height: 80)
            .shadow(color: .black, radius: 0.5)
            
            Text("\((Int)(current.temp))ºC")
                .font(.title3)
                .padding(.trailing)
            
            Text(current.weather[0].weatherDescription.rawValue.capitalized)
            .font(.title3)
        }
    }
}

struct HourCell_Previews: PreviewProvider {
    static var hourly = WeatherDataModel().forecast!.hourly
    
    static var previews: some View {
        HourCell(current: hourly[0])
    }
}
