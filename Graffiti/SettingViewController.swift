//
//  SettingViewController.swift
//  Graffiti
//
//  Created by Teng-Sheng Ho on 2019/9/24.
//  Copyright © 2019 Mh. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func logOutAction(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    @IBAction func settingAction(_ sender: Any) {
        self.performSegue(withIdentifier: "settingPage", sender: self)

    }
    @IBAction func photoAction(_ sender: Any) {
        self.performSegue(withIdentifier: "photoPage", sender: self)

    }
    @IBAction func profileAction(_ sender: Any) {
        self.performSegue(withIdentifier: "profilePage", sender: self)

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
