//
//  WeatherDetailsViewController.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import UIKit
import SwiftSVG

protocol WeatherDetailsViewControllerProtocol {
    func display(cityName: String)
    func display(temp: Int)
    func display(conditionName: String)
    func getImage(url: URL)
    func display(minTemp: Int)
    func display(maxTemp: Int)
    func display(windSpeed: Double)
    func display(windDirection: String)
    func display(pressure: Int)
    func display(humidity: Int)
    func display(sunrise: String)
    func display(sunset: String)
}

class WeatherDetailsViewController: UIViewController {
    
    // MARK: IB Outlets
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var conditionNameLabel: UILabel!
    
    @IBOutlet var conditionImage: UIView!
    
    @IBOutlet var minTempLabel: UILabel!
    @IBOutlet var maxTempLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    @IBOutlet var pressureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var sunriseLabel: UILabel!
    @IBOutlet var sunsetLabel: UILabel!
    
    // MARK: Properties
    var presenter: WeatherDetailsPresenterProtocol!
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLabels()
        presenter.updateInterface()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Подробно"
    }
    
    private func setupLabels() {
        cityNameLabel.textColor = .black
        tempLabel.textColor = .black
        conditionNameLabel.textColor = .black
        minTempLabel.textColor = .black
        maxTempLabel.textColor = .black
        windSpeedLabel.textColor = .black
        windDirectionLabel.textColor = .black
        pressureLabel.textColor = .black
        humidityLabel.textColor = .black
        sunsetLabel.textColor = .black
        sunriseLabel.textColor = .black
    }
}

// MARK: WeatherDetailsViewControllerProtocol
extension WeatherDetailsViewController: WeatherDetailsViewControllerProtocol {
    func display(cityName: String) {
        self.cityNameLabel.text = cityName
    }
    
    func display(temp: Int) {
        self.tempLabel.text = "\(String(temp))°C"
    }
    
    func display(conditionName: String) {
        self.conditionNameLabel.text = conditionName
    }
    
    func getImage(url: URL) {
        let weatherImage = UIView(SVGURL: url) {(image) in
            image.resizeToFit(self.conditionImage.bounds)
        }
        conditionImage.addSubview(weatherImage)
    }
    
    func display(minTemp: Int) {
        self.minTempLabel.text = "Мин. \(String(minTemp))°C"
    }
    
    func display(maxTemp: Int) {
        self.maxTempLabel.text = "Макс. \(String(maxTemp))°C"
    }

    func display(windSpeed: Double) {
        windSpeedLabel.text = "Скорость ветра: \(String(windSpeed)) м/с"
    }
    
    func display(windDirection: String) {
        windDirectionLabel.text = "Ветер: \(windDirection)"
    }
    
    func display(pressure: Int) {
        pressureLabel.text = "Давление: \(String(pressure)) мм рт. ст."
    }
    
    func display(humidity: Int) {
        humidityLabel.text = "Влажность: \(String(humidity)) %"
    }
    
    func display(sunrise: String) {
        sunriseLabel.text = "Восход солнца: \(sunrise)"
    }
    
    func display(sunset: String) {
        sunsetLabel.text = "Заход солнца: \(sunset)"
    }
}

