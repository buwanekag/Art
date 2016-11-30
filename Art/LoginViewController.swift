//
//  LoginViewController.swift
//  Art
//
//  Created by Buwaneka Galpoththawela on 6/6/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    
     var backendless = Backendless.sharedInstance()
    
    
    
    @IBAction func loginButtonTapped(_ sender:AnyObject){
        
        let userEmail = emailTextField.text
        let userPassword = passwordTextField.text
        
       
            
            backendless.userService.login(
                userEmail, password:userPassword,
                response: { ( registeredUser : BackendlessUser!) -> () in
                    print("User has been logged in (ASYNC): \(registeredUser)")
                    
                    self.dismiss(animated: true, completion: nil)
                },
                error: { ( fault : Fault!) -> () in
                    print("Server reported an error: \(fault)")
                }
            )
      
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
