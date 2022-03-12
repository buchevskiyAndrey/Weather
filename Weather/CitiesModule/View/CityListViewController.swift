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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        viewModel.fetchCities { error in
            if let error = error {
                print(error)
            }
        }
        viewModel.cities.bind { [weak self] _ in
            guard let self = self else { return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
            searchController.searchResultsUpdater = self

            searchController.searchBar.delegate = self
            searchController.delegate = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Enter a company name or symbol"
            searchController.searchBar.autocapitalizationType = .allCharacters
            searchController.searchBar.tintColor = .systemYellow
//            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.title = "Search"
//            navigationController!.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.searchController = searchController
        }
  
  
    
    //    private var viewModel: TableViewViewModelProtocol!

    
//    private var view: MainView!
//
//    override func viewDidLoad() {
//        viewModel = MainViewModel()
//        super.viewDidLoad()
//
//    }
//
//    private func creteView() {
//        view = MainView()
//        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        view.center = view.center
//        view.addSubview(view)
//    }
//
//    private func updateView() {
//        viewModel.updateViewData = { [weak self] viewData in
//            self?.view.viewData = viewData
//        }
//    }
}

extension CityListViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        
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
