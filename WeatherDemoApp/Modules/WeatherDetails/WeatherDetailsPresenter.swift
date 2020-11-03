//
//  WeatherDetailsPresenter.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import Foundation

protocol WeatherDetailsPresenterProtocol {
    init(view: WeatherDetailsViewControllerProtocol, weather: [String : Weather])
    func updateInterface()
}

class WeatherDetailsPresenter: WeatherDetailsPresenterProtocol {
    
    let view: WeatherDetailsViewControllerProtocol
    let currentWeather: [String : Weather]
    
    required init(view: WeatherDetailsViewControllerProtocol, weather: [String : Weather]) {
        self.view = view
        self.currentWeather = weather
    }
    
    func updateInterface() {
        guard let city = currentWeather.first?.key else { return }
        guard let weather = currentWeather.first?.value else { return }
        
        view.display(cityName: city)
        view.display(temp: weather.temperature)
        view.display(conditionName: weather.conditionString)
        view.display(minTemp: weather.tempMin)
        view.display(maxTemp: weather.tempMax)
        view.display(windSpeed: weather.windSpeed)
        view.display(windDirection: weather.windDirectionString)
        view.display(pressure: weather.presureMm)
        view.display(humidity: weather.humidity)
        view.display(sunrise: weather.sunrise)
        view.display(sunset: weather.sunset)
        
        guard let url = URL(string: "\(Requests.baseImageUrl + weather.conditionCode).svg") else { return }
        view.getImage(url: url)
    }
}
