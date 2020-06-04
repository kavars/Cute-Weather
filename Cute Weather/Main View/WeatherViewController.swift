//
//  ViewController.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 26.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    
    
//    var citiesID: [Int] = [Int](repeating: 524894, count: 1)
    
    let networking = Networking()
    var city: WeatherResponse?
    
    // Moscow
    var cityID = 524894
    

    //MARK: Navigate
    // Navigate To Cities List
    @IBAction func sitiesList(_ sender: UIButton) {
        performSegue(withIdentifier: "toCitiesList", sender: self)
    }
    
    // Unwind Segue From Cities List
    @IBAction func Done(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? SearchViewController {
            if let cityID = sourceViewController.selectCityID {
                self.cityID = cityID
            }
        }
        // get weather for new city
        updateWeather()
    }
    
    // get response
    func getWeather(cityID: Int, completion: (() -> Void)?) {
        networking.performNetworkTask(endpoint: OpenWeatherAPI.cityID(id: cityID), type: WeatherResponse.self) { [weak self] (response) in
            self?.city = response
            completion?()
        }
    }
    
    func updateWeather() {
        getWeather(cityID: cityID) { [weak self] in
            self?.updateUI()
        }
    }

    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 1 //citiesID.count
        pageControl.currentPage = 0
        pageControl.hidesForSinglePage = true
        
        configureRefreshControl()
        updateWeather()
    }
    
    //MARK: UIUpdate
    func updateUI() {
        if let city = self.city {
            DispatchQueue.main.async {
                self.cityLabel.text = city.name
                self.temperatureLabel.text = String(Int(city.main.temp-271))
                self.feelsLikeLabel.text = String(Int(city.main.feels_like-271))
                self.humidityLabel.text = String(city.main.humidity)
                self.pressureLabel.text = String(city.main.pressure)
            }
        }
    }
}

//MARK: Refresh Control
extension WeatherViewController {
    
    func configureRefreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        updateWeather()
        
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
}
