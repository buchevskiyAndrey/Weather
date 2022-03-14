//
//  DetailViewController.swift
//  Weather
//
//  Created by Андрей Бучевский on 12.03.2022.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {
    //MARK: - IBOutlet
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
     
    
    //MARK: - Public properties
    weak var coordinator: DetailCoordinator?
    var viewModel: WeatherViewModel?
    var city: String = ""
    
    
    //MARK: - View lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViewModel()
        viewModel?.fetchWeather(for: city, completion: { error in
            guard let error = error else {return}
            print(error)
        })
    }
    
    private func setupViews() {
        let image = UIImage(systemName: "star.fill")
        let barButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(saveCity))

        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func saveCity() {
        print("I will save")
    }
    
    private func bindViewModel() {
        viewModel?.weather.bind(listener: { [weak self] _ in
            print("ok")
            guard let self = self else {return}
            DispatchQueue.main.async {  
                self.cityNameLabel.text = self.viewModel?.weather.value?.cityName
                self.weatherImage.image = UIImage(systemName: self.viewModel?.weather.value?.systemIconNameString ?? "nosign")
                self.weatherDescriptionLabel.text = self.viewModel?.weather.value?.weatherDescription
                self.tempLabel.text = self.viewModel?.weather.value?.temperatureString
                self.minTempLabel.text = self.viewModel?.weather.value?.tempMinString
                self.maxTempLabel.text = self.viewModel?.weather.value?.tempMaxString
                self.humidityLabel.text = self.viewModel?.weather.value?.humidityLabel
                self.pressureLabel.text = self.viewModel?.weather.value?.pressureLabel
                self.windSpeedLabel.text = self.viewModel?.weather.value?.windSpeedString
                self.windDirectionLabel.text = self.viewModel?.weather.value?.windDirectionString
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

