//
//  UserDetailVC.swift
//  PeopleAndAppleStockPrices
//
//  Created by casandra grullon on 12/3/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var userInfo: UserInfo?
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI(){
        guard let user = userInfo else {
            return
        }
        nameLabel.text = "\(user.name.first.capitalized) \(user.name.last.capitalized)"
        emailLabel.text = user.email
        cityLabel.text = user.location.city.capitalized
        
        UserPicture.getPicture(for: user.picture.medium) { [unowned self] (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
