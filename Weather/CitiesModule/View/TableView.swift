//
//  MainView.swift
//  Weather
//
//  Created by Андрей Бучевский on 10.03.2022.
//

import UIKit

class MainView: UIView {
//lazt let label
    var viewData: ViewData = .initial {
        didSet {
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            update(viewData: nil, isHidden: true)
//            activityIndicator = true
//            activi = stop
        case .loading(let loading):
            update(viewData: loading, isHidden: false)
//            activity = fal
        case .success(let success):
            update(viewData: success, isHidden: false)
        case .failure(let failure):
            update(viewData: failure, isHidden: false)

        }
    }
    
    private func update(viewData: ViewData.WeatherData?, isHidden: Bool) {
        
    }
}
