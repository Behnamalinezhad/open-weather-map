//
//  WeatherResponse.swift
//  openWeatherApp
//
//  Created by Behnam on 5/2/22.
//

import Foundation
import UIKit

struct WeatherResponse: Codable {
    
    let lat: Float?
    let lon: Float?
    let timezone: String?
    let timezone_offset: Float?
    let current: CurrentWeather?
    let daily: [DailyWeather]?
}

struct CurrentWeather: Codable {
    let de: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Double?
    let feels_like: Double?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let uvi: Int?
    let clouds: Int?
    let visibility: Int?
    let wind_speed: Double?
    let wind_deg: Double?
    let weather: [Weather]?
    
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct DailyWeather: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let moonrise: Int?
    let moonset: Int?
    let moon_phase: Double?
    let temp: Temp?
    let feels_like: FeelsLike?
    let pressure: Int?
    let humidity: Int?
    let dew_point: Double?
    let wind_speed: Double?
    let wind_deg: Int?
    let wind_gust: Double?
    let weather: [Weather]?
    let clouds: Int?
    let pop: Double?
    let rain: Double?
    let uvi: Double?
}

struct Temp: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

struct FeelsLike: Codable {

}

