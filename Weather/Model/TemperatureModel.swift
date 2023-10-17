//
//  Temperature.swift
//  Weather
//
//  Created by Олимджон Садыков on 05/10/23.
//

import Foundation

struct TemperatureModel: Codable {
    let location: LocationModel
    let current: CurrentModel
    let forecast: ForecastModel
}
