//
//  WeatherDetailViewController.swift
//  openWeatherApp
//
//  Created by Behnam on 5/4/22.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var TempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!

    var temp = String()
    var imageName = String()
    var lowTemp = String()
    var highTemp = String()
    var sunrice = String()
    var sunset = String()
    var pressure = String()
    var humadity = String()



    override func viewDidLoad() {
        super.viewDidLoad()
        TempLabel.text = temp
        lowTempLabel.text = "Low: \(lowTemp)"
        highTempLabel.text = "High: \(highTemp)"
        iconImageView.image = UIImage(named: imageName)
        sunriseLabel.text = "Sunrise: \(sunrice)"
        sunsetLabel.text = "Sunset: \(sunset)"
        pressureLabel.text = "Pressure: \(pressure)"
        humidityLabel.text = "Humadity: \(humadity)"

    }
}
