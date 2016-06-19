//
//  RegisterViewController.swift
//  Art
//
//  Created by Buwaneka Galpoththawela on 6/5/16.
//  Copyright © 2016 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

    class RegisterViewController: UIViewController {
        
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!
        @IBOutlet weak var repeatPasswordTextField: UITextField!
        

        
        var backendless = Backendless.sharedInstance()
        
       
          //MARK: Interactive Method
        
       
        
        @IBAction func registerButtonPressed(sender:UIButton){
            let userEmail = emailTextField.text
            let userPassword = passwordTextField.text
            let userRepeatPassword = repeatPasswordTextField.text
            
            if (userEmail!.isEmpty || userPassword!.isEmpty || userRepeatPassword!.isEmpty) {
                
                displayAlertMessage("All fields are required")
                
            }
            
            
            if (userPassword != userRepeatPassword){
                
                displayAlertMessage("Passwords do not match")
            }
        
            
                
                let user = BackendlessUser()
                user.email = userEmail
                user.password = userPassword
            
                
                backendless.userService.registering(user,
                response: { ( registeredUser : BackendlessUser!) -> () in
                print("User has been registered (ASYNC): \(registeredUser)")
                let myAlert = UIAlertController(title: "Alert",message: "Registration is successful,Thank You",preferredStyle: .Alert)
                let okAction = UIAlertAction(title: "Ok",style: UIAlertActionStyle.Default){ action in
                    self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert,animated: true,completion: nil)
                    
                    },
                error: { ( fault : Fault!) -> () in
                print("Server reported an error: \(fault)")
                    let myAlert = UIAlertController(title: "Alert",message: "Registration was not successful,Try Again",preferredStyle: .Alert)
                    let okAction = UIAlertAction(title: "Ok",style: UIAlertActionStyle.Default){ action in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    myAlert.addAction(okAction)
                    self.presentViewController(myAlert,animated: true,completion: nil)
                    
                    
                    }
                )
         
            
        }
        
        
        
       
        func displayAlertMessage(userMessage:String){
            
            let myAlert = UIAlertController(title:"Alert",message: userMessage,preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok",style: UIAlertActionStyle.Default,handler: nil)
            
            myAlert.addAction(okAction)
            self.presentViewController(myAlert,animated: true,completion: nil)
        }
        
    
    
    
    
    
  
    
      
    //MARK: Life Cycle Method
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
