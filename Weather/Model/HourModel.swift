//
//  HourModel.swift
//  Weather
//
//  Created by Олимджон Садыков on 10/10/23.
//

import Foundation

struct HourModel: Codable {
    let time: String
    let temp_c: Double
    let condition: ConditionModel
}
