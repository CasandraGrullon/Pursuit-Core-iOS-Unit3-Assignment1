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
        searchBar.delegate = self
  }
    func loadData(){
        user = User.getUser()
    }

    func filterSearch(for searchText: String){
        user = User.getUser().filter { $0.name.first.lowercased().contains(searchText.lowercased()) }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? UserDetailVC, let indexPath = tableview.indexPathForSelectedRow else {
            fatalError("issue with segue")
        }
        detailVC.userInfo = user[indexPath.row]
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

extension UserVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        filterSearch(for: searchText)
    }
}
