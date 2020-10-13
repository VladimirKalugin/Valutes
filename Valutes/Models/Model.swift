//
//  Model.swift
//  Valutes
//
//  Created by Fuhrer_SS on 13.10.2020.
//

import Foundation

// MARK: - Valutes
struct Valutes: Codable {
    let valute: [String: Valute]

    enum CodingKeys: String, CodingKey {
        case valute = "Valute"
    }
}

// MARK: - Valute
struct Valute: Codable {
    let charCode: String
    let nominal: Int
    let name: String
    let value: Double

    enum CodingKeys: String, CodingKey {
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
    }
}
