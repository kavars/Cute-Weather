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
    
    var citiesID: [Int] = [0, 524894]
    var weatherViews: [WeatherView] = [WeatherView]()
    
    var frame = CGRect.zero

    //MARK: Navigation
    // Navigate To Cities List
    @IBAction func sitiesList(_ sender: UIButton) {
        performSegue(withIdentifier: "toCitiesList", sender: self)
    }
    
    // Delete Weather View
    @IBAction func deleteWeatherView(_ sender: UIButton) {
        let index = pageControl.currentPage
        
        if index != 0 {
            // Remove from id array
            citiesID.remove(at: index)
            
            // Change content size
            scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(citiesID.count)), height: scrollView.frame.size.height)
            
            // Check view and remove it from scroll view
            if scrollView.subviews[index] === weatherViews.remove(at: index) {
                scrollView.subviews[index].removeFromSuperview()
            }
            
            // Move all pages
            for (indexView, weatherView) in weatherViews.enumerated() {
                weatherView.frame.origin.x = scrollView.frame.size.width * CGFloat(indexView)
                weatherView.frame.size = scrollView.frame.size
            }
            
            // Update number of pages
            pageControl.numberOfPages = citiesID.count
        } else {
            print("It's first page")
        }
    }
    
    // Unwind Segue From Cities List
    @IBAction func Done(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? SearchViewController {
            if let cityID = sourceViewController.selectCityID {
                if !citiesID.contains(cityID) {
                    citiesID.append(cityID)
                    createWeatherView(index: citiesID.count - 1)
                    pageControl.numberOfPages = citiesID.count
                    pageControl.currentPage = citiesID.count - 1
                }
            }
        }
    }
    
    //MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = citiesID.count
        
        createWeatherViewLocation()


        
        setupScreens()
        scrollView.delegate = self
        pageControl.hidesForSinglePage = true
    }
    
    //MARK: Add new city
    func createWeatherView(index: Int) {
        
        let weatherView: WeatherView = Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)?.first as! WeatherView
        weatherView.frame.origin.x = scrollView.frame.size.width * CGFloat(index)
        weatherView.frame.size = scrollView.frame.size
        
        
        weatherViews.append(weatherView)
        
        let weatherViewHandler = WeatherID(id: citiesID[index])
        
        weatherView.delegate = weatherViewHandler
        
        weatherView.configureRefreshControl()
        
        weatherView.delegate?.getWeather(weatherView, completion: { [weak self] in
            DispatchQueue.main.async {
                if let controller = self {
                    weatherView.updateUI()
                    controller.scrollView.addSubview(weatherView)
                }
            }
        })
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(citiesID.count)), height: scrollView.frame.size.height)
        
        // auto transmission to the new view
        scrollView.scrollRectToVisible(weatherView.frame, animated: true)

    }
    
    func createWeatherViewLocation() {
        let weatherView: WeatherView = Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)?.first as! WeatherView
        weatherView.frame.origin.x = scrollView.frame.size.width * CGFloat(0)
        weatherView.frame.size = scrollView.frame.size
        
        weatherViews.append(weatherView)
        
        let weatherViewHandler = WeatherLocation()
        weatherView.delegate = weatherViewHandler
        
        weatherView.configureRefreshControl()
        
        self.scrollView.addSubview(weatherView)

        weatherView.delegate?.getWeather(weatherView) {
            DispatchQueue.main.async {
                weatherView.updateUI()
            }
        }
                
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(citiesID.count)), height: scrollView.frame.size.height)
    }
    
    //MARK: Setup at start up
    func setupScreens() {
        for index in 1..<citiesID.count {
            createWeatherView(index: index)
        }
        pageControl.currentPage = 1
    }
    
}

//MARK: UIScrollViewDelegate
extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
}
