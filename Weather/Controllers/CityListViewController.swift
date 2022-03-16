//
//  ViewController.swift
//  Weather
//
//  Created by Андрей Бучевский on 09.03.2022.
//

import UIKit

class CityListViewController: UITableViewController, Storyboarded {
    var weatherViewModel = WeatherViewModel()
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel.changeTempUnit(tempUnit: .celsius)
        } else if sender.selectedSegmentIndex == 1 {
            viewModel.changeTempUnit(tempUnit: .fahrenheit)
        }
    }
    
    //MARK: - Private properties
    private var searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
      }
    private var isSearching: Bool {
        
        return searchController.isActive && !isSearchBarEmpty
      }
        
    //MARK: - Public properties
    var viewModel: CityListViewModel!
    var coordinator: CityCoordinator?
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        viewModel.fetchCities { error in
            if let error = error {
                print(error)
            }
        }
        viewModel.loadData()
        bindViewModel()
        weatherViewModel.delegate = self
        print("CityList was loaded")
    }
    
    //MARK: - TableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(isSearching: isSearching)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSearching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCell
            let cityViewModel = viewModel.titleForSearchingCell(atIndexPath: indexPath)
            cell.cityViewModel = cityViewModel
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            let weatherViewModel = viewModel.titleForFavouriteCell(atIndexPath: indexPath)
            cell.weatherViewModel = weatherViewModel
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (coordinates, unit) = viewModel.didSelectRowAt(indexPath: indexPath, isSearching: isSearching)
        coordinator?.showDetail(for: coordinates, unit: unit, weatherViewModel: weatherViewModel)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    //MARK: - Private methods
    private func setUpSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a city"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Cities"
        navigationItem.searchController = searchController
    }
    
    private func bindViewModel() {
        viewModel.filteredSearchCities.bind { [weak self] _ in
            guard let self = self else { return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.favouriteCities.bind { [weak self] _ in
            guard let self = self else { return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

    //MARK: - Extensions
extension CityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(for: searchText.lowercased())
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension CityListViewController: ReturnViewModelProtocol {
    func transferViewModel(_ importer: WeatherViewModel, viewModel: WeatherCellViewModel) {
        self.viewModel.save(viewModel: viewModel)
    }
}
