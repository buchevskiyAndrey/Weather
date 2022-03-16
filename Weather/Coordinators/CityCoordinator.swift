//
//  CityCoordinator.swift
//  Weather
//
//  Created by Андрей Бучевский on 15.03.2022.
//

import UIKit

class CityCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let cityListViewController = CityListViewController.instantiate()
        let cityListViewModel = CityListViewModel()
        cityListViewController.viewModel = cityListViewModel
        cityListViewController.coordinator = self
        navigationController.setViewControllers([cityListViewController], animated: false)
    }
    
    func showDetailFromSearch(for coordinates: (String, String), unit: String, weatherViewModel: WeatherViewModel) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        detailCoordinator.coordinates = coordinates
        detailCoordinator.tempUnit = unit
        detailCoordinator.weatherViewModel = weatherViewModel
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    func showDetailAtFromFavourite(city viewModel: WeatherCellViewModel, unit: String) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        detailCoordinator.tempUnit = unit
        detailCoordinator.weatherViewModel = WeatherViewModel()
        detailCoordinator.weatherCellViewModel = viewModel
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    
    func childDidFinish(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {coordinator -> Bool in
            return child === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
