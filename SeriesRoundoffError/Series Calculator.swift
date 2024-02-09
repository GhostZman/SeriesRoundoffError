//
//  Series Calculator.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 1/26/24.
//

import Foundation
import SwiftUI
import Observation

@Observable class FiniteSeries {
    
    var maxIndex: Int = 1
    var series1Result: Float = 0.0
    var series2Result: Float = 0.0
    var series3Result: Float = 0.0
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    
    func computeSeries(N: Int){
        
        Task{
            
            let combinedResults = await withTaskGroup(of: (Int, Float).self,
                                                      returning:[(Int,Float)].self,
                                                      body: { taskGroup in
                
                taskGroup.addTask{
                    let series1 = await SeriesElement().series1Element(N: N)
                    
                    return series1
                }
                
                taskGroup.addTask{
                    let series2 = await SeriesElement().series2Element(N: N)
                    
                    return series2
                }
                
                taskGroup.addTask{
                    let series3 = await SeriesElement().series3Element(N: N)
                    
                    return series3
                }
                
                var combinedTaskResults :[(Int, Float)] = []
                for await result in taskGroup {
                    combinedTaskResults.append(result)
                }
                return combinedTaskResults
            })
            let sortedCombinedResults = combinedResults.sorted(by: { $0.0 < $1.0 })
            self.series1Result = sortedCombinedResults[0].1
            self.series2Result = sortedCombinedResults[1].1
            self.series3Result = sortedCombinedResults[2].1
        }
    }
    
    func plotserieserror() async {
        
        await resetCalculatedTextOnMainThread()
        
        theText = "y = Series Error"
        
        var plotData :[(x: Double, y: Double)] = []
        for i in 1 ... 50 {
            let x = i
            
            computeSeries(N: i)
            sleep(2)
            let y = abs((Double(series1Result)-Double(series3Result))/Double(series3Result))
            
            let dataPoint: (x: Double, y: Double) = (x: Double(x), y: y)
            plotData.append(contentsOf: [dataPoint])
            theText += "x = \(x), y = \(y)\n"
        }
        await setThePlotParameters(color: "Blue", xLabel: "N", yLabel: "Series Error", title: "Number of Elements vs Series Error", xMin: 0, xMax: 10, yMin: -1, yMax: 1)
        
        await appendDataToPlot(plotData: plotData)
        await updateCalculatedTextOnMainThread(theText: theText)
        
    }
    
    /// Adds the passed text to the display in the main window
    /// - Parameter theText: Text Passed To Add To Display
    @MainActor func updateCalculatedTextOnMainThread(theText: String) {
        //Print Header
        plotDataModel!.calculatedText += theText
    }
    
    /// This appends data to be plotted to the plot array
    /// - Parameter plotData: Array of (x, y) points to be added to the plot
    @MainActor func appendDataToPlot(plotData: [(x: Double, y: Double)]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    /// Set the Plot Parameters
    /// - Parameters:
    ///   - color: Color of the Plotted Data
    ///   - xLabel: x Axis Label
    ///   - yLabel: y Axis Label
    ///   - title: Title of the Plot
    ///   - xMin: Minimum value of x Axis
    ///   - xMax: Maximum value of x Axis
    ///   - yMin: Minimum value of y Axis
    ///   - yMax: Maximum value of y Axis
    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String, xMin: Double, xMax: Double, yMin:Double, yMax:Double) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = yMax
        plotDataModel!.changingPlotParameters.yMin = yMin
        plotDataModel!.changingPlotParameters.xMax = xMax
        plotDataModel!.changingPlotParameters.xMin = xMin
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red"{
            plotDataModel!.changingPlotParameters.lineColor = Color.red
        }
        else{
            
            plotDataModel!.changingPlotParameters.lineColor = Color.blue
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    @MainActor func resetCalculatedTextOnMainThread() {
        //Print Header
        plotDataModel!.calculatedText = ""

    }
}
