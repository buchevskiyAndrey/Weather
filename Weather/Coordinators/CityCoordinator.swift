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
    
//    weak var parentCoordinator: AppCoordinator?
//    var city: String = ""
    
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
    
    func showDetail(for city: String, unit: String) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController)
        detailCoordinator.city = city
        detailCoordinator.tempUnit = unit
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    
//    func didFinish() {
//        parentCoordinator?.childDidFinish(self)
    //    }
    
    
    func childDidFinish(_ child: Coordinator) {
        if let index = childCoordinators.firstIndex(where: {coordinator -> Bool in
            return child === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
