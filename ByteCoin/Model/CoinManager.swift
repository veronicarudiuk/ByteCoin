//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "33EDE4E9-F954-46B1-AEEC-F92AECED496A"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func fetchCoinPrice (for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        perfomRequest(with: urlString)
    }
    
    func perfomRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, responce, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
//                    var backToString = String(data: safeData, encoding: .utf8)
//                    print(backToString!)
                    if let rate = parseJSON(safeData) {
                        print(rate)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            return decodedData.rate
        } catch {
            return nil
        }
    }
}

