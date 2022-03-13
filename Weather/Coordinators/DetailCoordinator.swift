//
//  CityListCoordinator.swift
//  Weather
//
//  Created by Андрей Бучевский on 13.03.2022.
//

import UIKit

class DetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: AppCoordinator?
    var city: String = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DetailViewController.instantiate()

        vc.city = city
        vc.viewModel = WeatherViewModel()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
}

