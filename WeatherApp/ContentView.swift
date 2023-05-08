//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mikolaj Jakobiak on 08/05/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Navbar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(WeatherDataModel())
    }
}
