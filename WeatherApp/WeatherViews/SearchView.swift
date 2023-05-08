//
//  SearchView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var weatherData: WeatherDataModel
    @EnvironmentObject var pollutionData: PollutionDataModel
    
    @Binding var isSearchOpen: Bool
    @Binding var locationString: String
    @State var location = ""
    @State var errMsg = ""
    
    var body: some View {
        Spacer()
        ZStack {
            Color.teal
                .ignoresSafeArea()
            
            VStack{
                TextField(
                    "Enter New Location",
                    text: self.$location,
                    onCommit: {
                        Task {
                            await getLocation(location: location)
                        }
                    }
                )
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                
                if let msg = errMsg {
                    Text(msg)
                        .font(.title3)
                        .foregroundColor(.red)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                }
            }
        }
        Spacer()
    }
    
    func getLocation(location: String) async {
        do {
            let (lat, lon) = try await getLanLonFromLoc(location: location)
            if (lat == -1 && lon == -1) {
                self.errMsg = "Location Not Found\nPlease Try Again"
            }
            do {
                try await weatherData.loadData(lat: lat, lon: lon)
                try await pollutionData.loadData(lat: lat, lon: lon)
                locationString = await getLocFromLatLon(lat: lat, lon: lon)
            } catch {
                self.errMsg = "Something Went Wrong\nPlease Try Again"
            }
            
            isSearchOpen.toggle()

        } catch {
            self.errMsg = "Location Not Found\nPlease Try Again"
        }
    }
}
