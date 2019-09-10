//
//  LoginViewController.swift
//  Graffiti
//
//  Created by Teng-Sheng Ho on 2019/9/8.
//  Copyright © 2019 Mh. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var pwText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any) {
        
        if(userText.text != "" && pwText.text != ""){
            print("Username :"+userText.text!)
            print("password :"+pwText.text!)
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }else{
            print("sth wrong")
        }
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        
    }
}

