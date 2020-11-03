//
//  CitiesListViewController.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import UIKit

class CitiesListViewController: UIViewController {

    @IBOutlet var citiesTableView: UITableView!
    
    var namesCities = ["Москва", "Санкт-Петербург", "Ейск", "Воронеж", "Краснодар"]
    var weathers: [[String : Weather]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for city in namesCities {
            let nameOfCity = city
            print("NAME OF CITY \(nameOfCity)")
            LocationManager.shared.getCoordinateFrom(city: city) { (coordinate, error) in
                guard let coordinate = coordinate else { return }
                let latitude = coordinate.latitude
                let longitude = coordinate.longitude
                
                NetworkManager.shared.fetchWeatherData(latitude: latitude,
                                                       longitude: longitude) { (weather) in
                    self.weathers?.append([nameOfCity:weather])
                }
            }
        }
        /*
        LocationManager.shared.getCoordinateFrom(city: "Уфа") { (coordinate, error) in
            print(coordinate)
            
            guard let coordinate = coordinate else { return }
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            
            NetworkManager.shared.fetchWeatherData(latitude: latitude,
                                                   longitude: longitude) { (weather) in
                
            }
        }
        */
        
    }
}

