//
//  Series_Element.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 2/2/24.
//

import SwiftUI
import Observation

@Observable class SeriesElement {
    func series1Element(N: Int) async -> (Int, Double){
    
        var sum :Double = 0.0
        
        for i in 1...N{
            
            sum += 1.0/Double(i)
            
        }
        
        return (1, sum)
    }
    
    func series2Element(N: Int) async -> (Int, Double){
        
        var sum :Double = 0.0
        
        for i in N...1{
            
            sum += 1.0/Double(i)
            
        }
        
        
        return (2, sum)
    }
}
