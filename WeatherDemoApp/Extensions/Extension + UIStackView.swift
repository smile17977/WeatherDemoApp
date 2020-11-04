//
//  Extension + UIStackView.swift
//  WeatherDemoApp
//
//  Created by Kir Pir on 04.11.2020.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let rect = CGRect(x: Int(bounds.minX) - 10,
                          y: Int(bounds.minY) - 10,
                          width: Int(bounds.width) + 20,
                          height: Int(bounds.height) + 20)
        let subView = UIView(frame: rect)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layer.cornerRadius = 10
        insertSubview(subView, at: 0)
    }
}
