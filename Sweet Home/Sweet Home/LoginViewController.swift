//
//  LoginViewController.swift
//  Sweet Home
//
//  Created by Nikita Sherbakov on 17/6/19.
//  Copyright © 2019 Nikita Sherbakov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.keyboardType = UIKeyboardType.emailAddress
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                print("login succseful")
                                
                self.performSegue(withIdentifier: "goToSweetHome", sender: self)
            }
            
        }
    }
   

}
