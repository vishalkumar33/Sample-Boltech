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

    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.title = "Welcome"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navBarAppearance.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navBarAppearance.backgroundColor = UIColor(displayP3Red: 47/255,
                                                   green: 54/255, blue: 64/255, alpha: 1.0)
        btnLogin.backgroundColor = UIColor(displayP3Red: 47/255,
                                           green: 54/255, blue: 64/255, alpha: 1.0)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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

