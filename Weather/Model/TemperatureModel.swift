//
//  Temperature.swift
//  Weather
//
//  Created by Олимджон Садыков on 05/10/23.
//

import Foundation

struct TemperatureModel {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Double
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Int
    let hourly_units: HourlyUnitsModel
}
