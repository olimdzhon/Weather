//
//  File.swift
//  Weather
//
//  Created by Олимджон Садыков on 10/10/23.
//

import Foundation

struct ForecastModel: Codable {
    let forecastday: [ForecastdayModel]
}
