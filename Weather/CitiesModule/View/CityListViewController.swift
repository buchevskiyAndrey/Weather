//
//  ViewController.swift
//  Weather
//
//  Created by Андрей Бучевский on 09.03.2022.
//

import UIKit

class CityListViewController: UITableViewController {
    //MARK: - Private properties
    private var searchController = UISearchController(searchResultsController: nil)
    private var searchQuery: String!
    private var viewModel = CityListViewModel()
    private var filteredViewModel = CityListViewModel()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        viewModel.fetchCities { error in
            if let error = error {
                print(error)
            }
        }
        bindViewModel()
    }
    
    //MARK: - TableView data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCell
        let  cityViewModel = viewModel.titleForCell(atIndexPath: indexPath)
        cell.cityViewModel = cityViewModel
        return cell
    }
    
    //MARK: - Private methods
    private func setUpSearchBar() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter a city"
        searchController.searchBar.autocapitalizationType = .allCharacters
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
    }
    
    private func bindViewModel() {
        viewModel.filteredCities.bind { [weak self] _ in
            guard let self = self else { return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension CityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(for: searchText.lowercased())
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.search(for: "")
    }
    
    
//    //Устанавливает таймер на выполнение запроса при наборе текста в Search Bar'е
//    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        self.searchTimer?.invalidate()
//        let currentText = searchBar.text ?? ""
//        if (currentText as NSString).replacingCharacters(in: range, with: text).count >= 2 {
//            self.searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(performSearch), userInfo: nil, repeats: false)
//        }
//        return true
//    }
}
