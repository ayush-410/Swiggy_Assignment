//
//  APIService.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 03/03/26.
//

import Foundation

final class APIService {
    
    func fetchWeatherData(city: String, completion: @escaping (Result<WeatherData,ErrorType>) -> Void){
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constant.apiKey)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(.success(weatherData))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}

