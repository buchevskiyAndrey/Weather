//
//  ViewController.swift
//  Weather
//
//  Created by Андрей Бучевский on 09.03.2022.
//

import UIKit

class CityViewController: UITableViewController {
    var cityViewModels = [CityViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CityManager.shared.fetchCities(forName: "cityList") { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
            
            switch result {
            case .success(let cities):
                self.cityViewModels = cities?.map({return CityViewModel(city: $0)}) ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityCell
        let cityViewModel = cityViewModels[indexPath.row]
        cell.cityViewModel = cityViewModel
        return cell
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

