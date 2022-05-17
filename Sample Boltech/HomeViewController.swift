//
//  HomeViewController.swift
//  Sample Boltech
//
//  Created by Vishal Kumar on 17/05/22.
//

import UIKit
import Auth0
import JWTDecode
import VIBoltechTask

class HomeViewController: UIViewController {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    var credentials: Credentials?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetail()
    }
    
    func getUserDetail() {
        if let credentials = credentials {
            guard let jwt = try? decode(jwt: credentials.idToken),
                  let name = jwt.claim(name: "name").string,
                  let email = jwt.claim(name: "email").string else { return }
            self.lblName.text = name
            self.lblEmail.text = email
        }
    }
    
    @IBAction func navigateToSDK(_ sender: Any) {
        if let navigationController = self.navigationController, let token = self.credentials?.accessToken {
            let coordinator = MyDeviceCoordinator(navigationController: navigationController, bearerToken: token)
            coordinator.start()
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        Auth0
            .webAuth()
            .clearSession { result in
                switch result {
                case .success:
                    print("Logged out")
                    self.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
}
