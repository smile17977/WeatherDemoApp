//
//  Weather.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import Foundation

struct Weather {
    
    var name: String = "Название"
    var temperature: Int
    var conditionCode: String
    var url: String
    var condition: String
    var presureMm: Int
    var windSpeed: Double
    var tempMin: Int
    var tempMax: Int
    
    var conditionString: String {
        
        switch condition {
        case "clear" :                  return "ясно"
        case "partly-cloudy" :          return "малооблачно"
        case "cloudy" :                 return "облачно с прояснениями"
        case "overcast" :               return "пасмурно"
        case "drizzle" :                return "морось"
        case "light-rain" :             return "небольшой дождь"
        case "rain" :                   return "дождь"
        case "moderate-rain" :          return "умеренно сильный дождь"
        case "heavy-rain" :             return "сильный дождь"
        case "continuous-heavy-rain" :  return "длительный сильный дождь"
        case "showers" :                return "ливень"
        case "wet-snow" :               return "дождь со снегом"
        case "light-snow" :             return "небольшой снег"
        case "snow" :                   return "снег"
        case "snow-showers" :           return "снегопад"
        case "hail" :                   return "град"
        case "thunderstorm" :           return "гроза"
        case "thunderstorm-with-rain" : return "дождь с грозой"
        case "thunderstorm-with-hail" : return "гроза с градом"
        default :                       return "Loading"
        }
    }
    
    init(weatherData: WeatherData) {
        self.temperature = weatherData.fact?.temp ?? 000
        self.conditionCode = (weatherData.fact?.icon)!.rawValue
        self.url = weatherData.info?.url ?? ""
        self.condition = (weatherData.fact?.condition)!.rawValue
        self.presureMm = weatherData.fact?.pressureMm ?? 000
        self.windSpeed = weatherData.fact?.windSpeed ?? 000
        self.tempMin = weatherData.forecasts?.first?.parts?.day?.tempMin ?? 000
        self.tempMax = weatherData.forecasts?.first?.parts?.day?.tempMax ?? 000 
    }
}
