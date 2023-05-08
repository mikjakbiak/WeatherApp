//
//  PollutionView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct PollutionView: View {
    @EnvironmentObject var weatherData: WeatherDataModel
    @EnvironmentObject var pollutionData: PollutionDataModel
    @State var locationString = "No location"
    
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
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text("\((Int)(weatherData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.largeTitle)
                
                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherData.forecast!.current.weather[0].icon).png")) {image in
                        image.image?.resizable()
                    }
                    .frame(width: 80, height: 80)
                    .shadow(color: .black, radius: 0.5)
                    
                    Text(weatherData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                        .padding()
                        .font(.body)
                        .shadow(color: .black, radius: 0.5)
                }
                
                VStack {
                    HStack {
                        Text("High: \((Int)(weatherData.forecast!.daily[0].temp.max))ºC")
                            .padding()
                            .font(.body)
                            .shadow(color: .black, radius: 0.5)
                        
                        Text("Low: \((Int)(weatherData.forecast!.daily[0].temp.min))ºC")
                            .padding()
                            .font(.body)
                            .shadow(color: .black, radius: 0.5)
                    }
                    
                    Text("Feels Like: \((Int)(weatherData.forecast!.current.feelsLike))ºC")
                        .padding()
                        .font(.body)
                        .shadow(color: .black, radius: 0.5)
                }.padding()

                    AirQualityView(pollution: pollutionData.pollution)
                
            }.onAppear {
                Task.init {
                    self.locationString = await getLocFromLatLon(lat: weatherData.forecast!.lat, lon: weatherData.forecast!.lon)
                }
            }
        }
    }
}

struct Pollution_Previews: PreviewProvider {
    static var previews: some View {
        PollutionView()
            .environmentObject(WeatherDataModel())
            .environmentObject(PollutionDataModel())
    }
}
