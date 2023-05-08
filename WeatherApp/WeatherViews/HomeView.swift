//
//  HomeView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var weatherData: WeatherDataModel
    @State var isSearchOpen: Bool = false
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
                HStack {
                    Button {
                        self.isSearchOpen.toggle()
                    } label: {
                        Text("Change Location")
                            .bold()
                            .font(.system(size: 30))
                            .shadow(color: .black, radius: 0.5)
                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen, locationString: $locationString)
                    }
                    .padding()
                }
                Spacer()
                
                Text(locationString)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(weatherData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
                
                Spacer()
                
                Text("Temp: \((Int)(weatherData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity: \((Int)(weatherData.forecast!.current.humidity))%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Pressure: \((Int)(weatherData.forecast!.current.pressure)) hPa")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)

                HStack {
                    AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherData.forecast!.current.weather[0].icon).png")) {image in
                            image.image?.resizable()
                        }
                    .frame(width: 80, height: 80)
                    .shadow(color: .black, radius: 0.5)

                    Text(weatherData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
            }
        }.onAppear {
            Task.init {
                self.locationString = await getLocFromLatLon(lat: weatherData.forecast!.lat, lon: weatherData.forecast!.lon)
            }
        }
        
    }
}
