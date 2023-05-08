//
//  Location.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import Foundation
import CoreLocation

func getLocFromLatLon(lat: Double, lon: Double) async -> String {
    var locationString: String
    var placemarks: [CLPlacemark]
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    let ceo: CLGeocoder = CLGeocoder()
    
    let loc: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    do {
        placemarks = try await ceo.reverseGeocodeLocation(loc)
        
        if placemarks.count > 0 {
            if let country = placemarks[0].country {
                if let locality = placemarks[0].locality {
                    locationString = "\(locality), \(country)"
                } else {
                    locationString = "No City, \(country)"
                }
            } else {
                locationString = "No City, No Country"
            }
            
            return locationString
        }
    } catch {
        print("Reverse geodecoe fail: \(error.localizedDescription)")
        locationString = "No City, No Country"
       
        return locationString
    }
    
    return "Error getting Location"
}

func getLanLonFromLoc(location: String) async throws -> (Double, Double) {
    do {
        let placemarks = try await CLGeocoder().geocodeAddressString(location)
        if let lat = placemarks.first?.location?.coordinate.latitude,
           let lon = placemarks.first?.location?.coordinate.longitude {
            return (lat, lon)
        }
    } catch {
        throw error
    }
    
    return (-1, -1)
}
