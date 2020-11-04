//
//  CitiesListViewController.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 30.10.2020.
//

import UIKit

protocol CitiesListViewControllerProtocol {
    func moveToWeatherDetails(weather: [String : Weather])
    func removeRow(at indexPath: IndexPath)
    func checkSearchBarIsEmpty() -> Bool
    func checkSearchControllerIsActive() -> Bool
    func reloadData()
    func showAddNewCityAlert(title: String,
                   placeholder: String,
                   with completion: @escaping (String) -> Void)
    func showNotFoundCityAlert(with title: String,
                               and message: String)
    func insertCityAtRow(row: Int)
}

class CitiesListViewController: UIViewController {

    // MARK: IB Outlets
    @IBOutlet weak var citiesTableView: UITableView!

    // MARK: Properties
    private var presenter: CitiesListPresenterProtocol!
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupSearchController()
        setupView()
        presenter = CitiesListPresenter.init(view: self)
        presenter?.getCitiesWeather()
    }
    
    // MARK: UI
    private func setupTableView() {
        citiesTableView.backgroundColor = .white
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesTableView.register(UINib(nibName: "CityTableViewCell",
                                       bundle: nil),
                                 forCellReuseIdentifier: "CityTableViewCell")
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Введите название города"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Погода"
        view.backgroundColor = .white
    }

    // MARK: IB Actions
    @IBAction func buttonPressed(_ sender: Any) {
        presenter.addNewCityButtonPressed()
    }
    @IBAction func editButtonPressed(_ sender: Any) {
        if citiesTableView.isEditing {
            citiesTableView.isEditing = false
        } else {
            citiesTableView.isEditing = true
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func insertCityAtRow(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        citiesTableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.getCitiesCount()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = citiesTableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as! CityTableViewCell
        presenter.configure(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        presenter.selectedCellPressed(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.removeEditingCity(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        presenter.moveCurrentCity(sourceIndexPath: sourceIndexPath,
                                  destinationIndexPath: destinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if citiesTableView.isEditing {
            return .none
        } else {
            return .delete
        }
    }
    
    func tableView(_ tableView: UITableView,
                   shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        false
    }
}

// MARK: CitiesListViewControllerProtocol
extension CitiesListViewController: CitiesListViewControllerProtocol {
    
    func checkSearchControllerIsActive() -> Bool {
        return searchController.isActive
    }
    
    func checkSearchBarIsEmpty() -> Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    func removeRow(at indexPath: IndexPath) {
        citiesTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func moveToWeatherDetails(weather: [String : Weather]) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController = storyboard
            .instantiateViewController(identifier: "WeatherDetailsVC") as! WeatherDetailsViewController
        viewController.presenter = WeatherDetailsPresenter.init(view: viewController,
                                                                weather: weather)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.citiesTableView.reloadData()
        }
    }
}

// MARK: UISearchResultsUpdating
extension CitiesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        presenter.filterCitiesForSearchCity(city: searchController.searchBar.text!)
    }
}
