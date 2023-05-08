//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import Foundation

class WeatherDataModel: ObservableObject {
    @Published var forecast: Forecast?
    var apiKey: String

    init() {
        if let _apiKey = Bundle.main.infoDictionary?["OPEN_WEATHER_API_KEY"] as? String {
            self.apiKey = _apiKey
        } else {
            self.apiKey = ""
        }

        self.forecast = load("london_weather.json")
    }
    
    func loadData(lat: Double, lon: Double) async throws {
        let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=\(self.apiKey)")
        let session = URLSession(configuration: .default)
        
        let (data, _) = try await session.data(from: url!)
        
        do {
            let forecastData = try JSONDecoder().decode(Forecast.self, from: data)
            
            DispatchQueue.main.async {
                self.forecast = forecastData
            }
        } catch {
            throw error
        }
    }
    
    func load<Forecast: Decodable>(_ filename: String) -> Forecast {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Forecast.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(Forecast.self):\n\(error)")
        }
    }
}
