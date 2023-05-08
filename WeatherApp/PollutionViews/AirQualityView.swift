//
//  AirQualityView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct AirQualityView: View {
    var pollution: Pollution?
    
    var body: some View {
        VStack {
            Text("Air Quality Data:")
                .font(.title.bold())
                .foregroundColor(.black)
                .shadow(color: .black, radius: 0.5)
                .multilineTextAlignment(.center)
            
            HStack {
                VStack {
                    Image("so2")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                    Text("\(pollution?.list[0].components.so2.significand ?? 0.0, specifier: "%.2f")")
                        .font(.body)
                        .shadow(color: .black, radius: 0.5)
                }
                
                VStack {
                    Image("no")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                    Text("\(pollution?.list[0].components.no2 ?? 0.0, specifier: "%.2f")")
                        .font(.body)
                        .shadow(color: .black, radius: 0.5)
                }
                
                VStack {
                    Image("voc")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                    Text("\(pollution?.list[0].components.co ?? 0.0, specifier: "%.2f")")
                        .font(.body)
                        .shadow(color: .black, radius: 0.5)
                }
                
                VStack {
                    Image("pm")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                    Text("\(pollution?.list[0].components.pm2_5 ?? 0.0, specifier: "%.2f")")
                        .font(.body)
                        .shadow(color: .black, radius: 0.5)
                }
            }.padding()
        }
    }
}

struct AirQualityView_Previews: PreviewProvider {
    static let pollution = PollutionDataModel().pollution
    
    static var previews: some View {
        AirQualityView(pollution: pollution)
    }
}
