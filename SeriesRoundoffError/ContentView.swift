//
//  ContentView.swift
//  SeriesRoundoffError
//
//  Created by Phys440Zachary on 2/9/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    @Environment(PlotClass.self) var plotData
    
    @State private var calculator = FiniteSeries()
    @State var isChecked:Bool = false
    @State var tempInput = ""
    
    @State var selector = 0

    var body: some View {
        
        @Bindable var plotData = plotData
        
        VStack{
            
            Group{
                
                HStack(alignment: .center, spacing: 0) {
                    
                    Text($plotData.plotArray[selector].changingPlotParameters.yLabel.wrappedValue)
                        .rotationEffect(Angle(degrees: -90))
                        .foregroundColor(.red)
                        .padding()
                    VStack {
                        Chart($plotData.plotArray[selector].plotData.wrappedValue) {
                            LineMark(
                                x: .value("Position", $0.xVal),
                                y: .value("Height", $0.yVal)
                                    
                            )
                            .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                            PointMark(x: .value("Position", $0.xVal), y: .value("Height", $0.yVal))
                            
                            .foregroundStyle($plotData.plotArray[selector].changingPlotParameters.lineColor.wrappedValue)
                            
                            
                        }
                        .chartYScale(domain: [ plotData.plotArray[selector].changingPlotParameters.yMin ,  plotData.plotArray[selector].changingPlotParameters.yMax ])
                        .chartXScale(domain: [ plotData.plotArray[selector].changingPlotParameters.xMin ,  plotData.plotArray[selector].changingPlotParameters.xMax ])
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                        .padding()
                        Text($plotData.plotArray[selector].changingPlotParameters.xLabel.wrappedValue)
                            .foregroundColor(.red)
                    }
                }
               // .frame(width: 350, height: 400, alignment: .center)
                .frame(alignment: .center)
                
            }
            .padding()
    
            
            Divider()
            
            HStack{
                Button("Calculate", action: { Task.init{
                    
                    self.selector = 0
                    
                    await self.calculate()
                    
                    
                }
                }
                
                
                )
                .padding()
                
            }
            
        }
        
    
    }
    
    @MainActor func setupPlotDataModel(selector: Int){
        
        calculator.plotDataModel = self.plotData.plotArray[selector]
    }
    
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate() async {
        
        //pass the plotDataModel to the Calculator
        
        await setupPlotDataModel(selector: 0)
        
            
            let _ = await withTaskGroup(of:  Void.self) { taskGroup in



                taskGroup.addTask {
        
        
        
        //Calculate the new plotting data and place in the plotDataModel
        await calculator.plotserieserror()
        
             
                }

                
            }
            
  
        
        
    }
    

   
    
}

#Preview {
    ContentView()
}
