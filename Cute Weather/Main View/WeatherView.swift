//
//  WeatherView.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 04.06.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class WeatherView: UIView {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var delegate: WeatherViewDelegate?
    
    var city: WeatherResponse?

    //MARK: UIUpdate
    func updateUI() {
        if let city = self.city {
            DispatchQueue.main.async {
                self.cityName.text = city.name
                self.temp.text = String(Int(city.main.temp-271))
                self.feelsLike.text = String(Int(city.main.feels_like-271))
                self.humidity.text = String(city.main.humidity)
                self.pressure.text = String(city.main.pressure)
            }
        }
    }
}

extension WeatherView {
    func configureRefreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.attributedTitle = NSAttributedString(string: "Updating")
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {        
        delegate?.refreshControlHandler(self) {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
        
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    
}
