//
//  SettingViewController.swift
//  Graffiti
//
//  Created by Teng-Sheng Ho on 2019/9/24.
//  Copyright © 2019 Mh. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
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
