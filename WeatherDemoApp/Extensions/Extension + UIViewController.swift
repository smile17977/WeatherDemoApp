//
//  Extension + UIViewController.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 03.11.2020.
//

import UIKit

extension UIViewController {
    func showAddNewCityAlert(title: String,
                   placeholder: String,
                   with completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Добавить",
                                       style: .default) { (action) in
            let textField = alert.textFields?.first
            guard let city = textField?.text else { return }
            completion(city)
        }
        let cancelAction = UIAlertAction(title: "Отменить",
                                         style: .default)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        present(alert, animated: true)
    }
    
    func showNotFoundCityAlert(with title: String,
                               and message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}
