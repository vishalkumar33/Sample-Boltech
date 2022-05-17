//
//  ViewController.swift
//  Sample Boltech
//
//  Created by Vishal Kumar on 16/05/22.
//

import UIKit
import VIBoltechTask
import Auth0

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func sdkAction(_ sender: Any) {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    print("Obtained credentials: \(credentials)")
                    print(credentials.accessToken)
                    if let navigationController = self.navigationController {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        homeVC.credentials = credentials
                        navigationController.pushViewController(homeVC, animated: true)
                    }
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
}

