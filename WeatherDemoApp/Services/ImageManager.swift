//
//  ImageManager.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 03.11.2020.
//

import Foundation


class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(conditionCode: String, completion: @escaping (Data) -> Void) {
        
        guard let url = URL(string: "\(Requests.baseImageUrl + conditionCode).svg") else { return }
        
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, responce, error) in
            if let error = error { print(error) }
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
        dataTask.resume()
    }
}
