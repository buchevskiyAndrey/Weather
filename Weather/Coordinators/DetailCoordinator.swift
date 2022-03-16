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
    var weatherViewModel: WeatherViewModel!
    var weatherCellViewModel: WeatherCellViewModel?
    
    var coordinates: (String, String) = ("", "")
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
        vc.viewModel = weatherViewModel
        vc.coordinator = self
        if let weatherCellViewModel = weatherCellViewModel {
            vc.weatherCellViewModel = weatherCellViewModel
        }
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

