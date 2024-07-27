//
//  Weather.swift
//  WeatherAppAzam
//
//  Created by Eze Chidera Paschal on 26/07/2024.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let feels_like: Double
}
