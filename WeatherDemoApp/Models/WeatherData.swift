//
//  WeatherData.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {

    let info: Info?
    let fact: Fact?
    let forecasts: [Forecast]?
}

// MARK: - Fact
struct Fact: Codable {
    let temp, feelsLike: Int?
    let icon: String?
    let condition: String?
    let windSpeed, windGust: Double?
    let windDir: String?
    let pressureMm, pressurePa, humidity, uvIndex: Int?
    let soilTemp: Int?
    let soilMoisture: Double?
    let daytime: String?
    let polar: Bool?
    let season: String?
    let obsTime: Int?
    let accumPrec: [String: Double]?
    let source: String?
    let cloudness: Double?
    let precType: Int?
    let precStrength: Double?
    let isThunder: Bool?
    let mode: String?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case icon, condition
        case windSpeed = "wind_speed"
        case windGust = "wind_gust"
        case windDir = "wind_dir"
        case pressureMm = "pressure_mm"
        case pressurePa = "pressure_pa"
        case humidity
        case uvIndex = "uv_index"
        case soilTemp = "soil_temp"
        case soilMoisture = "soil_moisture"
        case daytime, polar, season
        case obsTime = "obs_time"
        case accumPrec = "accum_prec"
        case source, cloudness
        case precType = "prec_type"
        case precStrength = "prec_strength"
        case isThunder = "is_thunder"
        case mode = "_mode"
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String?
    let dateTs, week: Int?
    let sunrise, sunset: String?
    let riseBegin, setEnd: String?
    let moonCode: Int?
    let moonText: String?
    let parts: Parts?

    enum CodingKeys: String, CodingKey {
        case date
        case dateTs = "date_ts"
        case week, sunrise, sunset
        case riseBegin = "rise_begin"
        case setEnd = "set_end"
        case moonCode = "moon_code"
        case moonText = "moon_text"
        case parts
    }
}

// MARK: - Parts
struct Parts: Codable {
    let day: Day?
}

struct Day: Codable {
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

// MARK: - Info
struct Info: Codable {
    let url: String?
}
