//
//  WeatherViewMode.swift
//  openWeatherApp
//
//  Created by Behnam on 5/3/22.
//

import Foundation
import CoreLocation

let openWeatherBaseUrl = "https://api.openweathermap.org/data/2.5"
let ApiKey = "260094555f990a424a7540b562428fc1"

protocol WeatherViewModelDelegate: AnyObject {
    func weatherUpdateSuccess()
    func weatherUpdateFailed()
}

class WeatherViewModel {
    
    weak var delegate: WeatherViewModelDelegate?
    static let shared = WeatherViewModel()
    
    var weather: WeatherResponse?
    
    func fetchWeaterWithCordinate(cordinate: CLLocationCoordinate2D?) {
        guard let cordinate = cordinate  else { return }
        
        guard let url = URL(string: "\(openWeatherBaseUrl)/onecall?lat=\(cordinate.latitude)&lon=\(cordinate.longitude)&exclude=hourly&appid=\(ApiKey)") else { return }
        print(cordinate.latitude)
        print(cordinate.longitude)

        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
                
                guard let self = self else { return }
                guard let data = data, error == nil else {
                    print("something went wrong")
                    self.delegate?.weatherUpdateFailed()
                    return
                }
                
                DispatchQueue.main.async {
                    do {
                        self.weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                        self.delegate?.weatherUpdateSuccess()
                    }
                    catch let err {
                        self.delegate?.weatherUpdateFailed()
                        print("couldnt decode data because: \(err.localizedDescription)")
                    }
                }
                
            }).resume()
        }
    }
    
    func getTimeFormFormat(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: inputDate)
    }
}
