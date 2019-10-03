//
//  SignUpViewController.swift
//  Graffiti
//
//  Created by Teng-Sheng Ho on 2019/9/11.
//  Copyright © 2019 Mh. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var rePwField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //where to upload Name!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    @IBAction func signUpAction(_ sender: Any) {
        if pwField.text != rePwField.text{
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please comfirm your re-type password!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }else{
            
            Auth.auth().createUser(withEmail: emailField.text!, password: pwField.text!){ (user, error) in
                if error == nil {
                    self.performSegue(withIdentifier: "signUpToLoginPage", sender: self)
                }
                else{
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
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
