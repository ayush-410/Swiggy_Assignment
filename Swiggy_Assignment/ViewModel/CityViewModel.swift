//
//  CityViewModel.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 02/03/26.
//

import Foundation
import Combine


final class CityViewModel: ObservableObject {
    
    private let apiService = APIService()
    
    @Published var cities: [City] = []
    @Published var weatherData: WeatherData?
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    var mockCities: [City] = MockData.cities.map({
        City(id: UUID(), name: $0, isFavorite: false)
    })
    
    func fetchCities() {
        cities = mockCities
    }
    
    func fetchSortedCities() {
        cities = mockCities.sorted(by: { $0.name < $1.name })
    }
    
    func addToFavorites(city: City){
        if let index = mockCities.firstIndex(where: { $0.id == city.id }) {
            mockCities[index].isFavorite.toggle()
            fetchCities()
        } else {
            return
        }
    }
    
    
    func fetchWeatherData(city: String){
        apiService.fetchWeatherData(city: city) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    self.weatherData = weatherData
                    self.errorMessage = ""
                case .failure(let error):
                    self.errorMessage = error.rawValue
                    self.showErrorAlert = true
                }
            }
        }
    }
    
    func addCity(city: String){
        let newCityName = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let newCity = City(id: UUID(), name: newCityName, isFavorite: false)
        mockCities.append(newCity)
        fetchCities()
    }
    
    func filterFavoriteCity(){
        
        cities = mockCities.sorted(by: { $0.name < $1.name }).filter({$0.isFavorite == true})
    }
}
