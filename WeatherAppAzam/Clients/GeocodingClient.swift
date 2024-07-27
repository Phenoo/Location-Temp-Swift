//
//  GeocodingClient.swift
//  WeatherAppAzam
//
//  Created by Eze Chidera Paschal on 26/07/2024.
//

import Foundation


enum NetworkError: Error {
    case invalidResponse
}

struct GeocodingClient {
    
    func coordinateBycity(_ city: String) async throws -> Location? {
        let (data, response) = try await URLSession.shared.data(from: APIEndpoint.endpointURL(for: .coordinateByLocationName(city)))
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let locations = try JSONDecoder().decode([Location].self, from: data)
        
        return locations.first
    }
    
}
