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
        print(urlString)
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
                    var backToString = String(data: safeData, encoding: .utf8)
                    print(backToString!)
                }
            }
            
            task.resume()
        }
    }
}

