//
//  User.swift
//  PeopleAndAppleStockPrices
//
//  Created by casandra grullon on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct User: Codable {
    let results: [UserInfo]
}

struct UserInfo: Codable {
    let name : Name
    let email : String
    let location: Location
}

struct Name: Codable {
    let first: String
    let last: String
}

struct Location: Codable {
    let city: String
}

extension User {
    static func getUser() -> [UserInfo] {
        var user = [UserInfo]()
        
        guard let fileURL = Bundle.main.url(forResource: "userinfo", withExtension: "json") else {
            fatalError("issue with url")
        }
        
        do{
            let data = try Data(contentsOf: fileURL)
            let userData = try JSONDecoder().decode(User.self, from: data)
            user = userData.results.sorted {$0.name.first < $1.name.first}
        }catch {
            fatalError("\(error)")
        }
        
        return user
    }
    
}
