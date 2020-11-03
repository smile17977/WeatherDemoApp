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
    @IBOutlet var conditionImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViewCell()
    }
    
    func setupCell(city: String, weather: Weather) {
        cityNameLabel?.text = city
        cityTempLabel?.text = String(weather.temperature)
        
        if !weather.conditionCode.isEmpty {
            fetchImage(conditionCode: weather.conditionCode)
        }
    }
    
    private func setupViewCell() {
        cityNameLabel.textColor = .black
        cityTempLabel.textColor = .black
        backgroundColor = .white
    }
    
    private func fetchImage(conditionCode: String) {
        guard let url = URL(string: "\(Requests.baseImageUrl + conditionCode).svg") else { return }
        let weatherImage = UIView(SVGURL: url) {(image) in
            image.resizeToFit(self.conditionImage.bounds)
        }
        conditionImage.addSubview(weatherImage)
    }
}
