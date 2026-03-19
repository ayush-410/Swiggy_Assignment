//
//  CityWeatherView.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 03/03/26.
//

import SwiftUI

struct CityWeatherView: View {
    
    @ObservedObject var cityViewModel: CityViewModel
    @Binding var selectedCity: City
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        NavigationStack{
            
            VStack{
                
                if let weatherData = cityViewModel.weatherData {
                    
                    WeatherImageView(weatherImageCode: weatherData.weather.first?.icon ?? "")
                        .frame(width: 150, height: 150)
                    
                    List {
                        Section{
                            HStack{
                                Text("City")
                                Spacer()
                                Text(weatherData.name)
                            }
                            HStack{
                                Text("Temperature")
                                Spacer()
                                Text(String(format: "%g", weatherData.main.temp))
                            }
                            HStack{
                                Text("Description")
                                Spacer()
                                Text(weatherData.weather.first?.description ?? "")
                            }
                            HStack{
                                Text("Pressure")
                                Spacer()
                                Text("\(weatherData.main.pressure)")
                            }
                            HStack{
                                Text("Humidity")
                                Spacer()
                                Text(weatherData.name)
                            }
                            HStack{
                                Text("Latitude")
                                Spacer()
                                Text(String(format: "%g",weatherData.coord.lat))
                            }
                            HStack{
                                Text("Longitude")
                                Spacer()
                                Text(String(format: "%g",weatherData.coord.lon))
                            }
                        } header: {
                            Text("Weather Details")
                        }
                        
                        Section{
                            
                            Button(selectedCity.isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: selectedCity.isFavorite ? "star.fill":"star"){
                                selectedCity.isFavorite.toggle()
                                cityViewModel.addToFavorites(city: selectedCity)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                } else {
                    ProgressView()
                }
            }
            .navigationTitle("Today's Weather")
            .task {
                cityViewModel.fetchWeatherData(city: selectedCity.name)
            }
            .alert("Error Alert", isPresented: $cityViewModel.showErrorAlert) {
                Button("OK"){
                    dismiss()
                }
            } message: {
                Text(cityViewModel.errorMessage)
            }
        }
    }
}


#Preview {
    CityWeatherView(cityViewModel: CityViewModel(), selectedCity: .constant(City(id: UUID(), name: "City", isFavorite: false)))
}
