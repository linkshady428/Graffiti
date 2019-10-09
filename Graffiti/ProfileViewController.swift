//
//  ProfileViewController.swift
//  Graffiti
//
//  Created by Teng-Sheng Ho on 2019/9/24.
//  Copyright © 2019 Mh. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        let user = Auth.auth().currentUser
        emailLabel.text = "Email:" + ((user?.email)!)
        nameLabel.text = "Name:" + ((user?.displayName)!)
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        let user = Auth.auth().currentUser
        emailLabel.text = "Email:" + ((user?.email)!)
        nameLabel.text = "Name:" + ((user?.displayName)!)
    }
    

    
    @IBAction func settingAction(_ sender: Any) {
        self.performSegue(withIdentifier: "settingPage", sender: self)
    }
    @IBAction func photoAction(_ sender: Any) {
        self.performSegue(withIdentifier: "photoPage", sender: self)
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
