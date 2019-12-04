//
//  StocksViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by casandra grullon on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class StocksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var appleStocks = [AppleStock]() {
        didSet{
            tableView.reloadData()
        }
    }
    var sections = [[AppleStock]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        tableView.dataSource = self
        
    }
    
    func loadData(){
        appleStocks = AppleStock.getStocks()
        
        let sortedData = appleStocks.sorted {$0.label < $1.label}
        let sectionNames : Set<String> = Set(sortedData.map {$0.date})
        sections = Array(repeating: appleStocks, count: sectionNames.count)
        
        var currentIndex = 0
        var currentSection = sortedData.first?.date ?? ""
        
        for stock in sortedData {
            if stock.date == currentSection {
                sections[currentIndex].append(stock)
            } else {
                currentIndex += 1
                currentSection = stock.date
                sections[currentIndex].append(stock)
            }
        }
    }
    
}

extension StocksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        let stock = sections[indexPath.section][indexPath.row]
        
        cell.textLabel?.text = stock.date
        cell.detailTextLabel?.text = stock.open.description
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].first?.date
    }
    
}
