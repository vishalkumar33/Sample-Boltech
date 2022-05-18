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
    
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnNavigate: UIButton!
    var credentials: Credentials?
    let token = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkVPVjVIQUM1OXZHYm14RC1WUG9LYSJ9.eyJpc3MiOiJodHRwczovL2Rldi15dDB0amgtci51cy5hdXRoMC5jb20vIiwic3ViIjoiYXV0aDB8NjI4MzYzNmQ5OTBiNWIwMDY4ZWM5NTU2IiwiYXVkIjpbImh0dHBzOi8vYXV0aDAtYXBpLmNvbSIsImh0dHBzOi8vZGV2LXl0MHRqaC1yLnVzLmF1dGgwLmNvbS91c2VyaW5mbyJdLCJpYXQiOjE2NTI4NjE2ODAsImV4cCI6MTY1Mjk0ODA4MCwiYXpwIjoiclllcnBJRnl4YnIzZUc3a3JkcTRodkF4YlFBVmRSY1oiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIiwicGVybWlzc2lvbnMiOltdfQ.N_v6Sbit-ekVLD8wlavrj45uPlhpEKgBPe6Blaza2rH1yIEi4ATqsaEOnAyAGJyrjwWMWvQwSNFRw8KTPcKs7vbVePawv0d5aqlK0ZGHVx0F28qzKdDfPQAVXyHjbDsVxSYgR3mG1n_6aHvkwwxt_z0lyRP6ZDMMQiMA6JWR0uoGF9jACftKK2PCtpaRYajABle62SVbTOzqc2dC0w78vCjMHiQKxf3JqAgiBojSrfK8y5lp4G6s1A7nRTvKQwQs5YJFtcucmoZzKuqDgakyvkBU5LGnSO0zeRBQOiiwuX8xOfOlyKBPz_xamGHmDGL560reA6SIZmOdCLwuGaz57w"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        btnNavigate.backgroundColor = UIColor(displayP3Red: 47/255,
                                              green: 54/255, blue: 64/255, alpha: 1.0)
        btnLogout.backgroundColor = UIColor(displayP3Red: 47/255,
                                            green: 54/255, blue: 64/255, alpha: 1.0)
        getUserDetail()
    }
    
    func getUserDetail() {
        dump(credentials)
        if let credentials = credentials {
            guard let jwt = try? decode(jwt: credentials.idToken),
                  let name = jwt.claim(name: "name").string,
                  let email = jwt.claim(name: "email").string else { return }
            self.lblName.text = name
            self.lblEmail.text = email
        }
    }
    
    @IBAction func navigateToSDK(_ sender: Any) {
        if let navigationController = self.navigationController, let token = self.credentials?.idToken {
            let coordinator = MyDeviceCoordinator(navigationController: navigationController, bearerToken: self.token)
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
