//
//  SceneDelegate.swift
//  Weather
//
//  Created by Андрей Бучевский on 09.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        guard let window = window else {
//            return
//        }
//        let data =
//        CityManager.shared.fetchCities(forName: "cityList") { result in
//            switch result {
//            case .success(let cities):
//                self.viewModel.cities.value = cities?.compactMap({return CityCellViewModel(city: $0)}) ?? []
//            case .failure(let error):
//                DispatchQueue.main.async { [weak self] in
//                    guard let self = self else {return}
//                    print(error)
//                }
//            }
//        }
//
//        let tasks = TasksStorage().loadTasks()
//        let taskListController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TaskListController") as! TaskListController
//        taskListController.setTasks(tasks)
//        let navigationController = UINavigationController(rootViewController: taskListController)
//        self.window?.windowScene = windowScene
//        window.rootViewController = navigationController
//        window.makeKeyAndVisible()
        
    }
    
    
}

