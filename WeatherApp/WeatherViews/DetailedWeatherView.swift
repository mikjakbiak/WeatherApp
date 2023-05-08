//
//  DetailedWeatherView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct DetailedWeatherView: View {
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
                
                HStack {
                    Text("Wind Speed: \((Int)(weatherData.forecast!.current.windSpeed))m/s")
                        .padding()
                        .font(.title3)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Direction: \(convertDegToCardinal(deg: weatherData.forecast!.current.windDeg))")
                        .font(.title3)
                        .shadow(color: .black, radius: 0.5)
                }.padding()
                
                HStack {
                    Text("Humidity: \((Int)(weatherData.forecast!.current.humidity))%")
                        .padding()
                        .font(.title3)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Pressure: \((Int)(weatherData.forecast!.current.pressure)) hPa")
                        .font(.title3)
                        .shadow(color: .black, radius: 0.5)
                }.padding()
                
                HStack {
                    Image(systemName: "sunset.fill").renderingMode(.original)
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherData.forecast?.current.sunset ?? 0))))
                        .formatted(.dateTime.hour().minute()))
                    .padding()
                    .font(.title2)
                    .shadow(color: .black, radius: 0.5)
                    
                    Image(systemName: "sunrise.fill").renderingMode(.original)
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherData.forecast?.current.sunrise ?? 0))))
                        .formatted(.dateTime.hour().minute()))
                    .padding()
                    .font(.title2)
                    .shadow(color: .black, radius: 0.5)
                }
            }.onAppear {
                Task.init {
                    self.locationString = await getLocFromLatLon(lat: weatherData.forecast!.lat, lon: weatherData.forecast!.lon)
                }
            }
        }
    }
}

struct DetailedWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedWeatherView()
            .environmentObject(WeatherDataModel())
    }
}
