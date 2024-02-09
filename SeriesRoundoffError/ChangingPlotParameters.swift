//
//  ChangingPlotParameters.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 2/6/24.
//

import SwiftUI
import Observation
@Observable class ChangingPlotParameters {
    
    //These plot parameters are adjustable
    
    var xLabel: String = "x"
    var yLabel: String = "y"
    var xMax : Double = 2.0
    var yMax : Double = 2.0
    var yMin : Double = -1.0
    var xMin : Double = -1.0
    var lineColor: Color = Color.blue
    var title: String = "Plot Title"
    
}
