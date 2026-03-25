//
//  ContentView.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 02/03/26.
//

import SwiftUI

struct CityListView: View {
    
    @StateObject var cityViewModel = CityViewModel()
    @State var selectedCity: City = City(id: UUID(), name: "", isFavorite: false)
    @State var showCityWeatherView: Bool = false
    @State var showWeatherView: Bool = false
    @State var addedCity: String = ""
    
    var body: some View {
        NavigationStack{
            
            VStack{
                HStack{
                    TextField("Add city", text: $addedCity)
                        .textFieldStyle(.roundedBorder)
                    Button("Add"){
                        cityViewModel.addCity(city: addedCity)
                        addedCity = ""
                    }
                    .disabled(addedCity.isEmpty)
                }
                .padding()
                
                List(cityViewModel.cities){ city in
                        HStack{
                            Text(city.name.removingPercentEncoding ?? "")
                            Spacer()
                            Button {
                                cityViewModel.addToFavorites(city: city)
                            } label: {
                                city.isFavorite ? Image(systemName: "star.fill") : Image(systemName: "star")
                            }
                            .buttonStyle(.borderless)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCity = city
                            showWeatherView = true
                        }
                }
            }
            .navigationTitle("Cities")
            .navigationDestination(isPresented: $showWeatherView, destination: {
               CityWeatherView(cityViewModel: cityViewModel, selectedCity: $selectedCity)
            })
            .onAppear {
                cityViewModel.fetchCities()
            }
            .toolbar{
                
                Menu {
                    Button("Favorite"){
                        cityViewModel.filterFavoriteCity()
                    }
                    Button("Sorted"){
                        cityViewModel.fetchSortedCities()
                    }
                    Button("Clear Filter"){
                        cityViewModel.fetchCities()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
}

#Preview {
    CityListView()
}
