//
//  WeatherImageView.swift
//  Swiggy_Assignment
//
//  Created by Ayush Kumar Singh on 06/03/26.
//

import SwiftUI

struct WeatherImageView: View {
    
    let weatherImageCode: String
    
    var body: some View {
        
        AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weatherImageCode)@2x.png")) { image in
            image.resizable().scaledToFit()                
        } placeholder: {
            ProgressView()
        }
    }
}

#Preview {
    WeatherImageView(weatherImageCode: "")
}
