//
//  CitiesListPresenter.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import UIKit

protocol CitiesListPresenterProtocol {
    init(view: CitiesListViewControllerProtocol)
    
    func getCityAndWeather(city: String, index: Int)
    func getCitiesWeather()
    func getCitiesCount() -> Int
    func configure(cell: CityTableViewCell, indexPath: IndexPath)
    func addNewCityButtonPressed()
    func removeEditingCity(at indexPath: IndexPath)
    func selectedCellPressed(at indexPath: IndexPath)
    func filterCitiesForSearchCity(city: String)
    func moveCurrentCity(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath)
}

class CitiesListPresenter: CitiesListPresenterProtocol {
    
    private var citiesWeathers = [["Москва" : Weather()],
                                  ["Уфа" : Weather()],
                                  ["Ейск" : Weather()],
                                  ["Воронеж" : Weather()],
                                  ["Тюмень" : Weather()],
                                  ["Краснодар" : Weather()],
                                  ["Казань" : Weather()],
                                  ["Ярославль" : Weather()],
                                  ["Выборг" : Weather()],
                                  ["Норильск" : Weather()]]
    
    private var filteredCitiesWeathers = [[String : Weather]]()
    private var isFiltering: Bool {
        return view.checkSearchControllerIsActive() && !view.checkSearchBarIsEmpty()
    }
    
    private let view: CitiesListViewControllerProtocol
    
    required init(view: CitiesListViewControllerProtocol) {
        self.view = view
    }
    
    func getCitiesWeather() {
        for (index, city) in citiesWeathers.enumerated() {
            guard let town = city.first?.key else { return }
            getCityAndWeather(city: town, index: index)
        }
    }
    
    func getCityAndWeather(city: String, index: Int) {
        LocationManager.shared.getCoordinateFrom(city: city) { [weak self] (coordinate, error) in
            guard let coordinate = coordinate else {
                self?.view.showNotFoundCityAlert(with: "Ошибка!",
                                                and: "Город не найден")
                self?.citiesWeathers.removeLast()
                return
            }
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            
            NetworkManager.shared.fetchWeatherData(latitude: latitude,
                                                   longitude: longitude) { [weak self] (weather) in
                DispatchQueue.main.async {
                    self?.citiesWeathers[index].updateValue(weather, forKey: city)
                    self?.view.reloadData()
                }
            }
        }
    }
    
    // MARK: NumberOfRowsInSection
    func getCitiesCount() -> Int {
        if isFiltering {
            return filteredCitiesWeathers.count
        } else {
            return citiesWeathers.count
        }
    }
    
    // MARK: Cell Configuration
    func configure(cell: CityTableViewCell, indexPath: IndexPath) {
        let weatherInCity: [String : Weather]
        
        if isFiltering {
            weatherInCity = filteredCitiesWeathers[indexPath.row]
            guard let city = weatherInCity.first?.key else { return }
            guard let weather = weatherInCity.first?.value else { return }
            cell.setupCell(city: city, weather: weather)
        } else {
            weatherInCity = citiesWeathers[indexPath.row]
            guard let city = weatherInCity.first?.key else { return }
            guard let weather = weatherInCity.first?.value else { return }
            print("ICON \(weather.conditionCode) CITY \(city)")
            cell.setupCell(city: city, weather: weather)
        }
    }
    
    // MARK: Add New City
    func addNewCityButtonPressed() {
        self.view.reloadData()
        view.showAddNewCityAlert(title: "Добавление города",
                       placeholder: "Введите название города") { (city) in
            if city != "" {
                let newCity = city
                self.citiesWeathers.append([city : Weather()])
                self.getCityAndWeather(city: newCity, index: self.citiesWeathers.count - 1)
                self.view.insertCityAtRow(row: self.citiesWeathers.count - 1)
            } else {
                self.view.showNotFoundCityAlert(with: "Ошибка!",
                                                and: "Введите название города")
            }
        }
    }
    
    // MARK: Remove City
    func removeEditingCity(at indexPath: IndexPath) {
        let editingCity = citiesWeathers[indexPath.row].first?.key
        citiesWeathers[indexPath.row].removeValue(forKey: editingCity!)
        
        citiesWeathers.remove(at: indexPath.row)
        view.removeRow(at: indexPath)
    }
    
    // MARK: Open DetailsVC with Weather
    func selectedCellPressed(at indexPath: IndexPath) {
        let currentWeather: [String : Weather]
        
        if isFiltering {
            currentWeather = filteredCitiesWeathers[indexPath.row]
        } else {
            currentWeather = citiesWeathers[indexPath.row]
        }
        if currentWeather.first?.value != Weather() {
            view.moveToWeatherDetails(weather: currentWeather)
        }
    }
    
    // MARK: Filter cities
    func filterCitiesForSearchCity(city: String) {
        filteredCitiesWeathers = citiesWeathers.filter({ (weatherInCity: [String : Weather]) -> Bool in
            return (weatherInCity.first?.key.lowercased().contains(city.lowercased()))!
        })
        view.reloadData()
    }
    
    // MARK: Move cities
    func moveCurrentCity(sourceIndexPath: IndexPath, destinationIndexPath: IndexPath) {
        let currentTrack = citiesWeathers.remove(at: sourceIndexPath.row)
        citiesWeathers.insert(currentTrack, at: destinationIndexPath.row)
    }
}
