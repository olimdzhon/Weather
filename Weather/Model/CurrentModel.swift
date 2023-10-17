//
//  HourlyModel.swift
//  Weather
//
//  Created by Олимджон Садыков on 05/10/23.
//

import Foundation

struct HourlyModel: Codable {
    let time: [String]
    let temperature_2m: [Double]
}
