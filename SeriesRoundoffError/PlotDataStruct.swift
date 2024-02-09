//
//  PlotDataStruct.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 2/6/24.
//

import Foundation
import Charts

struct PlotDataStruct: Identifiable {
    var id: Double { xVal }
    let xVal: Double
    let yVal: Double
}

