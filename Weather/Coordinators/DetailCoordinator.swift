//
//  CityListCoordinator.swift
//  Weather
//
//  Created by Андрей Бучевский on 13.03.2022.
//

import UIKit

class DetailCoordinator: Coordinator {
    var modalNavigationController: UINavigationController?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: CityCoordinator?
    
    var coordinates: (Double, Double) = (0, 0)
    var tempUnit: String = ""
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DetailViewController.instantiate()
        modalNavigationController = UINavigationController()
        modalNavigationController?.setViewControllers([vc], animated: false)
        vc.coordinates = coordinates
        vc.tempUnit = tempUnit
        vc.viewModel = WeatherViewModel()
        vc.coordinator = self
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true, completion: nil)
        }
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSavingWeather() {
        navigationController.dismiss(animated: true, completion: nil)
    }
    deinit {
        print("deinit from cityCoordinator")
    }
   
    
}

