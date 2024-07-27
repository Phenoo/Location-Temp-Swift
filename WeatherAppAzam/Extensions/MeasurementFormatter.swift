//
//  MeasurementFormatter.swift
//  WeatherAppAzam
//
//  Created by Eze Chidera Paschal on 27/07/2024.
//

import Foundation


extension MeasurementFormatter {
     
    static func temperature(value: Double) -> String {
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.maximumFractionDigits = 0
        
        let formatter = MeasurementFormatter()
        
        let temp = Measurement(value: value, unit: UnitTemperature.kelvin)
        
        return formatter.string(from: temp)
    }
     
}
