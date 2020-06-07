//
//  WeatherLocation.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 07.06.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherLocation: NSObject, WeatherViewDelegate {
    
    weak var weatherView: WeatherView?
    
    let networking = Networking()
    let locationManager = CLLocationManager()
    
    var latitude: Double?
    var longitude: Double?
    
    override init() {
        super.init()
        
        setupLocationManager()
        retriveCurrentLocation()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        // request permission to get user location when the app is in use (ie. active)
        // this will show an alert box to the user
        locationManager.requestWhenInUseAuthorization()
    }
    
    func retriveCurrentLocation() {
        let status = CLLocationManager.authorizationStatus()
        
        if (status == .denied || status == .restricted || !CLLocationManager.locationServicesEnabled()) {
            // show alert to user telling them they need to allow location data to use some feature of your app
            return
        }
        
        // if haven't show location permission dialog before, show it to user
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        // at this point the authorization status is authorized
        // request location data once
        locationManager.requestLocation()
    }
    
    func getWeather(_ weatherView: WeatherView, completion: (() -> Void)?) {
        
        self.weatherView = weatherView
                
        if let lat = self.latitude, let lon = self.longitude {
            networking.performNetworkTask(endpoint: OpenWeatherAPI.coords(lat: lat, lon: lon), type: WeatherResponse.self) { (response) in
                weatherView.city = response
                
                completion?()
            }
        }
    }
    
    func refreshControlHandler(_ weatherView: WeatherView, completion: (() -> Void)?) {
        retriveCurrentLocation()
    }
}

extension WeatherLocation: CLLocationManagerDelegate {
    // handle delegate methods of location manager here
    
    // called when the authorization status is changed for the core location permission
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("location manager authorization status changed")
        
        switch status {
        case .authorizedAlways:
            print("user allow app to get location data when app is active or in background")
        case .authorizedWhenInUse:
            print("user allow app to get location data only when app is active")
        case .denied:
            print("user tap 'disallow' on the permission dialog, can't get location data")
        case .restricted:
            print("parental control setting disallow location data")
        case .notDetermined:
            print("the location permission dialog haven't shown before, user haven't tap allow/disallow")
        @unknown default:
            fatalError("Unknown authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // add handler
        print("Error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // .requestLocation will only pass one location to the locations array
        // hence we can access it by taking the first element of the array
        if let location = locations.first {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude

            if let view = self.weatherView {
                getWeather(view) {
                    DispatchQueue.main.async {
                        view.updateUI()
                    }
                }
            }
        }
    }
}
