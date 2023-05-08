// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Pollution.self, from: jsonData)

import Foundation

// MARK: - Pollution
struct Pollution: Codable {
    let coord: Coord
    let list: [ListStruct]
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - ListStruct
struct ListStruct: Codable {
    let main: MainStruct
    let components: PollutionType
    let dt: Int
}

// MARK: - PollutionType
struct PollutionType: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm2_5: Double
    let pm10: Double
    let nh3: Double
}

// MARK: - MainStruct
struct MainStruct: Codable {
    let aqi: Int
}
