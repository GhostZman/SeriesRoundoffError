//
//  PlotClass.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 2/6/24.
//

import Foundation
import Observation

@Observable class PlotClass {
    
    var plotArray = [PlotDataClass.init(fromLine: true)]
    
    init() {
        self.plotArray = [PlotDataClass.init(fromLine: true)]
        self.plotArray.append(contentsOf: [PlotDataClass.init(fromLine: true)])
            
        }

    
}
