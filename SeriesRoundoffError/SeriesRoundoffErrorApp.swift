//
//  SeriesRoundoffErrorApp.swift
//  SeriesRoundoffError
//
//  Created by Phys440Zachary on 2/9/24.
//

import SwiftUI
import Observation

@main
struct SeriesRoundoffErrorApp: App {
    
    @State var plotData = PlotClass()
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environment(plotData)
                    .tabItem {
                        Text("Plot")
                    }
        }
    }

}

