//
//  ContentView.swift
//  WeatherAppAzam
//
//  Created by Eze Chidera Paschal on 26/07/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var city: String = ""
    @State private var isFetchingWeather : Bool = false

    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    
    @State private var weather: Weather?
    @State private var coordinate: Location?
    
    private func fetchWeather() async {
        do {
            guard let location = try await geocodingClient.coordinateBycity(city) else {
                return
            }
            coordinate = location
            weather = try await weatherClient.fetchWeather(location: location)
        } catch {
            print(error)
        }
    }
    
    private var region: MKCoordinateRegion {
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: coordinate?.lat ?? 34.011_286, longitude: coordinate?.lon ?? 116.166_868 ),
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
        }
    
    var body: some View {
        VStack {
            

            TextField("City", text: $city)
                .textFieldStyle(.roundedBorder)
                .border(Color.black)
                .foregroundStyle(.black)
                .onSubmit {
                    isFetchingWeather = true
                }.task(id: isFetchingWeather) {
                    if isFetchingWeather {
                        await fetchWeather()
                        isFetchingWeather = false
                        city = ""
                    }
                }
                .padding()

            
            Spacer()
            
            if let weather {
                VStack{
                    Text(coordinate?.name ?? "Miami")

                    Map(position: .constant(.region(region)))
                        .frame(height: 300)
                    
                    Text(MeasurementFormatter.temperature(value: weather.temp))
                        .font(.system(size: 70))
                        .padding()
                    
                    Text("\(weather.feels_like)")

                }
            }
            Spacer()

        }
        
        
    }
}

#Preview {
    ContentView()
}
