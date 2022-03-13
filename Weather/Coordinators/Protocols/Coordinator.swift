//
//  Coordinator.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

