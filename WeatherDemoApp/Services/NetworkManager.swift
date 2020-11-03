//
//  NetworkManager.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Weather) -> Void) {
        
        let cityWeatherUrl = "lat=\(latitude)&lon=\(longitude)&extra=true"
        let stringURL = Requests.baseWeatherUrl + cityWeatherUrl
        guard let url = URL(string: stringURL) else { return }
        
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.addValue(ApiKey.key, forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, responce, error) in
            guard let data = data else { return }
            if let weather = self.parseJSON(withData: data) {
                DispatchQueue.main.async {
                    completion(weather)
                }
            }
        }.resume()
    }
    
    private func parseJSON(withData data: Data) -> Weather? {
        
        let decoder = JSONDecoder()

        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            let weather = Weather(weatherData: weatherData)
            return weather
        } catch let error {
            print(error)
        }
        return nil
    }
}
