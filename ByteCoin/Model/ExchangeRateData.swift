//
//  ExchangeRateData.swift
//  ByteCoin
//
//  Created by Sandun Liyanage on 11/28/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct ExchangeRateData: Codable {
    var asset_id_quote: String
    var rate: Double
    
    var price: String {
        return String(format: "%.2f", rate)
    }
}
