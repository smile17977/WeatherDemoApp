//
//  Weather.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import Foundation

struct Weather: Equatable {
    
    var temperature: Int = 0
    var conditionCode: String = ""
    var url: String = "Загрузка"
    var condition: String = "Загрузка"
    var presureMm: Int = 0
    var windSpeed: Double = 0
    var windDirection: String = "Загрузка"
    var humidity: Int = 0
    var tempMin: Int = 0
    var tempMax: Int = 0
    var sunrise: String = "Загрузка"
    var sunset: String = "Загрузка"
    
    var conditionString: String {
        
        switch condition {
        case "clear" :                  return "Ясно"
        case "partly-cloudy" :          return "Малооблачно"
        case "cloudy" :                 return "Облачно с прояснениями"
        case "overcast" :               return "Пасмурно"
        case "drizzle" :                return "Морось"
        case "light-rain" :             return "Небольшой дождь"
        case "rain" :                   return "Дождь"
        case "moderate-rain" :          return "Умеренно сильный дождь"
        case "heavy-rain" :             return "Сильный дождь"
        case "continuous-heavy-rain" :  return "Длительный сильный дождь"
        case "showers" :                return "Ливень"
        case "wet-snow" :               return "Дождь со снегом"
        case "light-snow" :             return "Небольшой снег"
        case "snow" :                   return "Снег"
        case "snow-showers" :           return "Снегопад"
        case "hail" :                   return "Град"
        case "thunderstorm" :           return "Гроза"
        case "thunderstorm-with-rain" : return "Дождь с грозой"
        case "thunderstorm-with-hail" : return "Гроза с градом"
        default :                       return "Loading"
        }
    }
    
    var windDirectionString: String {
        
        switch windDirection {
        case "nw": return "северо-западный"
        case "n":  return "северный"
        case "ne": return "северо-восточный"
        case "e":  return "восточный"
        case "se": return "юго-восточный"
        case "s":  return "южный"
        case "sw": return "юго-западный"
        case "w":  return "западный"
        case "с":  return "штиль"
        default :  return "Loading"
        }
    }
    
    init() {}
    
    init(weatherData: WeatherData) {
        self.temperature = weatherData.fact?.temp ?? 000
        self.conditionCode = weatherData.fact?.icon ?? ""
        self.url = weatherData.info?.url ?? ""
        self.condition = weatherData.fact?.condition ?? ""
        self.presureMm = weatherData.fact?.pressureMm ?? 0
        self.humidity = weatherData.fact?.humidity ?? 0
        self.windSpeed = weatherData.fact?.windSpeed ?? 0.0
        self.windDirection = weatherData.fact?.windDir ?? ""
        self.tempMin = weatherData.forecasts?.first?.parts?.day?.tempMin ?? 000
        self.tempMax = weatherData.forecasts?.first?.parts?.day?.tempMax ?? 000
        self.sunset = weatherData.forecasts?.first?.sunset ?? ""
        self.sunrise = weatherData.forecasts?.first?.sunrise ?? ""
    }
}
