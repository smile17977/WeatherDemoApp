//
//  CityTableViewCell.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityTempLabel: UILabel!
    @IBOutlet var conditionNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewCell()
    }
    
    func setupCell(city: String, weather: Weather) {
        cityNameLabel?.text = city
        cityTempLabel?.text = String("\(weather.temperature)°C")
        conditionNameLabel.text = weather.conditionString
    }
    
    private func setupViewCell() {
        cityNameLabel.textColor = .black
        cityTempLabel.textColor = .black
        conditionNameLabel.textColor = .black
        backgroundColor = .white
    }
}
