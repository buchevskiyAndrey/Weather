//
//  CityListViewContoller + Extensions.swift
//  Weather
//
//  Created by Андрей Бучевский on 17.03.2022.
//

import Foundation
import UIKit

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
