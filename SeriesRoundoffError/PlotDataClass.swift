//
//  PlotDataClass.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 2/6/24.
//

import Foundation
import SwiftUI
import Observation

@Observable class PlotDataClass {
    
    @MainActor var plotData = [PlotDataStruct]()
    @MainActor var changingPlotParameters: ChangingPlotParameters = ChangingPlotParameters()
    @MainActor var calculatedText = ""
    //In case you want to plot vs point number
    @MainActor var pointNumber = 1.0
    
    init(fromLine line: Bool) {
        
        
        //Must call super init before initializing plot
        //super.init()
       
        Task{
            //Intitialize the first plot
            await self.plotBlank()
            
        }
        
       }
    
    
    
    /// Displays a Blank Chart
    @MainActor func plotBlank()
    {
        zeroData()
        
        //set the Plot Parameters
        changingPlotParameters.yMax = 4.0
        changingPlotParameters.yMin = -1.0
        changingPlotParameters.xMax = 4.0
        changingPlotParameters.xMin = -1.0
        changingPlotParameters.xLabel = "x"
        changingPlotParameters.yLabel = "y"
        changingPlotParameters.lineColor = Color.red
        changingPlotParameters.title = "y = x"
        
        
        
    }
    
    /// Zeros Out The Data Being Plotted
    @MainActor func zeroData(){
            
            plotData = []
            pointNumber = 1.0
            
        }
    
    /// Append Data appends Data to the Plot. Increments the pointNumber for 1-D Data
    /// - Parameter dataPoint: Array of (x, y) data for plotting
    @MainActor func appendData(dataPoint: [(x: Double, y: Double)])
        {
          
            for item in dataPoint{
                
                let dataValue :[PlotDataStruct] =  [.init(xVal: item.x, yVal: item.y)]
                
                plotData.append(contentsOf: dataValue)
                pointNumber += 1.0
                
            }
            
        }
    
    

}
