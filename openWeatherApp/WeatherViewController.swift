//
//  ViewController.swift
//  openWeatherApp
//
//  Created by Behnam on 5/2/22.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var weatherTblView: UITableView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var summery: UILabel!
    @IBOutlet weak var tempture: UILabel!
    
    var currentWeather: CurrentWeather!
    var dailyWeather = [DailyWeather]()
    let viewModel = WeatherViewModel()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Open Weather Map"
        weatherTblView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)

        weatherTblView.delegate = self
        weatherTblView.dataSource = self
        viewModel.delegate = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil  {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            viewModel.fetchWeaterWithCordinate(cordinate: locations.first?.coordinate)
        }
    }
    
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return models count
        return viewModel.weather?.daily?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: viewModel.weather?.daily?[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let svc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailWeatherVC") as! WeatherDetailViewController
        svc.imageName = viewModel.weather?.daily?[indexPath.row].weather?.first?.main?.lowercased() ?? ""
        svc.temp = "\(Int((viewModel.weather?.daily?[indexPath.row].temp?.day ?? 0.0) - 273.15))°c"
        svc.lowTemp = "\(Int((viewModel.weather?.daily?[indexPath.row].temp?.min ?? 0.0) - 273.15))°c"
        svc.highTemp = "\(Int((viewModel.weather?.daily?[indexPath.row].temp?.max ?? 0.0) - 273.15))°c"
        svc.sunrice = viewModel.getTimeFormFormat(Date(timeIntervalSince1970: TimeInterval(Int(viewModel.weather?.daily?[indexPath.row].sunrise ?? 0))))
        svc.sunset = viewModel.getTimeFormFormat(Date(timeIntervalSince1970: TimeInterval(Int(viewModel.weather?.daily?[indexPath.row].sunset ?? 0))))
        svc.pressure = "\(viewModel.weather?.daily?[indexPath.row].pressure ?? 0)"
        svc.humadity = "\(viewModel.weather?.daily?[indexPath.row].humidity ?? 0)"

        navigationController?.pushViewController(svc, animated: true)

//        svc.modalPresentationStyle = .fullScreen
//            self.present(svc, animated: true, completion: nil)

    }
    
    
}

extension WeatherViewController: WeatherViewModelDelegate {
    func weatherUpdateSuccess() {
        
        self.location.text = viewModel.weather?.timezone
        self.summery.text = viewModel.weather?.current?.weather?.first?.description
        self.tempture.text = "\(Int((viewModel.weather?.current?.temp ?? 0.0) - 273.15))°c"
        self.weatherTblView.reloadData()
        
    }
    
    func weatherUpdateFailed() {
        let ac = UIAlertController(title: "Ops", message: "Weather Unavailable.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }
}
