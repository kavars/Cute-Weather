//
//  SearchViewController.swift
//  Cute Weather
//
//  Created by Kirill Varshamov on 27.05.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var selectCityID: Int?
    
    var cities: [CityCell]?
        
    let networking = Networking()

    //MARK: View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        cities = nil
    }
    
    
    //MARK: Table View Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "SearchTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("The dequeued cell is not an instance of SearchTableViewCell.")
        }
        
        cell.cityName.text = cities?[indexPath.row].name
        cell.country.text = cities?[indexPath.row].country
        cell.cityID = cities?[indexPath.row].id
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = cities?.count {
            return count
        } else {
            return 0
        }
    }
    
    // Select city and unwind to main view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchTableViewCell {

            if let cityID = cell.cityID {
                selectCityID = cityID
                
                self.performSegue(withIdentifier: "unwindToWeather", sender: self)
            }
        }
    }
    
    
    
}

//MARK: Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.count > 1 {
            networking.performNetworkTask(endpoint: CityIDAPI.cityName(name: searchText), type: [CityCell].self) { [weak self] (response) in
                self?.cities = response
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        } else {
            cities = [CityCell]()
            tableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder() // [general] Connection to daemon was invalidated
    }
}
