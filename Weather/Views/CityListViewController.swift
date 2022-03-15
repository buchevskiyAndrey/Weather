//
//  ViewController.swift
//  Weather
//
//  Created by Андрей Бучевский on 09.03.2022.
//

import UIKit

class CityListViewController: UITableViewController, Storyboarded {
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
    var coordinator: AppCoordinator?
    
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
        print("CityList was loaded")
    }
    
    //MARK: - TableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return viewModel.numberOfRowsInSectionForSearch()
        } else {
            return viewModel.numberOfRowsInSectionForFavouriteList()
        }
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCell
        let cityViewModel: CityCellViewModel?
        if isSearching {
            cityViewModel = viewModel?.titleForCellForSearch(atIndexPath: indexPath)
        } else {
            cityViewModel = viewModel.titleForCellForFavouriteList(atIndexPath: indexPath)
        }
        cell.cityViewModel = cityViewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city: String
        if isSearching {
            city = viewModel.didSelectRowAtForSearch(atIndexPath: indexPath)
        } else {
            city = viewModel.didSelectRowAtForFavouriteList(atIndexPath: indexPath)
        }
        coordinator?.showDetail(for: city)
    }
    
    //MARK: - Private methods
    private func setUpSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a city"
//        searchController.searchBar.autocapitalizationType = .allCharacters
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Weather"
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

