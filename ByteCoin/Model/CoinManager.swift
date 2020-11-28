//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

protocol CoinManagerDelegate {
    func didUpdatePrice(_ coinManager: CoinManager, exchangeRateData: ExchangeRateData)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = APIKey().apiKey //replace with api key from coinapi.io
    
    let currencyArray = ["JPY", "AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func fetchExchangeRate(for currency: String) {
        let resourceURL = "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)/?apikey=\(apiKey)"
        performRequest(with: resourceURL)
    }
    
    func performRequest(with resourceURL: String) {
        // create URL
        let url = URL(string: resourceURL)
        
        if let safeURL = url{
            //create URL session
            let session = URLSession(configuration: .default)
            
            //give session a task
            let task = session.dataTask(with: safeURL) { (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error!)
                    return
                }

                if let safeData = data{
                    let decoder = JSONDecoder()
                    
                    do{
                        let exchangeRateData = try decoder.decode(ExchangeRateData.self, from: safeData)
                        delegate?.didUpdatePrice(self, exchangeRateData: exchangeRateData)
                    } catch{
                        delegate?.didFailWithError(error)
                    }
                }
            }
            //start the tast
            task.resume()
        }
        
    }
}
