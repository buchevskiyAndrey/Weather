//
//  AppCoordinator.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import UIKit

class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = CityListViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = CityListViewModel()
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    func showDetail(for city: String) {
        let child = DetailCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        child.city = city
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        // Read the view controller we’re moving from.
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
        if let detailViewController = fromViewController as? DetailViewController {
            // We're popping a buy view controller; end its coordinator
            childDidFinish(detailViewController.coordinator)
        }
    }
}
