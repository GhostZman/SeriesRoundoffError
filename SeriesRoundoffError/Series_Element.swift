//
//  Series_Element.swift
//  Finite Series Subtraction Error
//
//  Created by Phys440Zachary on 2/2/24.
//

import SwiftUI
import Observation

@Observable class SeriesElement {
    func series1Element(N: Int) async -> (Int, Float){
    
        var sum :Float = 0.0
        
        for i in 1...2*N{
            
            sum += Float(pow(-1.0, Float(i)))*Float(i)/(Float(i)+1)
            
        }
        
        return (1, sum)
    }
    
    func series2Element(N: Int) async -> (Int, Float){
        
        var sumnegative :Float = 0.0
        var sumpositive :Float = 0.0
        
        for i in 1...N{
            
            sumnegative += Float(2*Float(i) - 1)/Float(2*Float(i))
            sumpositive += Float(2*Float(i))/Float(2*Float(i) + 1)
            
        }
        
        let sum = -1*sumnegative+sumpositive
        
        return (2, sum)
    }
    
    func series3Element(N: Int) async -> (Int, Float){
        
        var sum :Float = 0.0
        
        for i in 1...N{
            
            sum += 1/Float(2*Float(i)*(2*Float(i) + 1))
            
        }
        
        return (3, sum)
    }
}
