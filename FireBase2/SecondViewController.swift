//
//  SecondViewController.swift
//  FireBase2
//
//  Created by Кирилл Крамар on 20.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var moreInfo: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print(user?.email ?? "", user?.displayName ?? "")
        }
    }
    
}
