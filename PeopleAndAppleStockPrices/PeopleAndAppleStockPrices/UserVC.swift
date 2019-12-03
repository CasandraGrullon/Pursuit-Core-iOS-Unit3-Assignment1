//
//  ViewController.swift
//  PeopleAndAppleStockPrices
//
//  Created by Alex Paul on 12/7/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class UserVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var user = [UserInfo](){
        didSet{
            tableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        loadData()
        tableview.dataSource = self
  }
    func loadData(){
        user = User.getUser()
    }


}

extension UserVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let userInfo = user[indexPath.row]
        
        cell.textLabel?.text = "\(userInfo.name.first.capitalized) \(userInfo.name.last.capitalized)"
        cell.detailTextLabel?.text = userInfo.location.city.capitalized
        
        
        return cell
    }
}
