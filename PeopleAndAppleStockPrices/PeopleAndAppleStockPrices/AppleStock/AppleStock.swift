//
//  AppleStock.swift
//  PeopleAndAppleStockPrices
//
//  Created by casandra grullon on 12/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct AppleStock: Codable {
    let date: String
    let close: Double
    let open: Double
    let label: String
}

var appleStocks = [AppleStock]()

extension AppleStock {
    static func getStocks() -> [AppleStock] {
        var stockInfo = [AppleStock]()
        
        guard let fileURL = Bundle.main.url(forResource: "applstockinfo", withExtension: "json") else {
            fatalError("no url")
        }
        
        do{
            let data = try Data(contentsOf: fileURL)
            let stockData = try JSONDecoder().decode([AppleStock].self, from: data)
            stockInfo = stockData.sorted {$0.date < $1.date}
        }catch {
            fatalError("\(error)")
        }
        return stockInfo
    }
    
//    static func getSections() -> [[AppleStock]] {
//        let sortedData = appleStocks.sorted {$0.date < $1.date}
//        let sectionNames : Set<String> = Set(sortedData.map {$0.date})
//        var sections = Array(repeating: appleStocks, count: sectionNames.count)
//
//        var currentIndex = 0
//        var currentSection = sortedData.first?.date ?? ""
//
//        for stock in sortedData {
//            if stock.date == currentSection {
//                sections[currentIndex].append(stock)
//            } else {
//                currentIndex += 1
//                currentSection = stock.date
//                sections[currentIndex].append(stock)
//            }
//        }
//        return sections
//    }
}
