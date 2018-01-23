//
//  LoginController.swift
//  LoginTest
//
//  Created by Tsuneo Ootoshi on 2018/01/23.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController,UITextFieldDelegate {
    
    let URL_USER_LOGIN = "https://www.goodsystem27.com/logintest.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard

    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    

    
    @IBAction func buttonLogin(_ sender: Any) {
        
        //getting the username and password
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                print(response)
                
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary

                    if(!(jsonData.value(forKey: "error") as! Bool)){

                        let user = jsonData.value(forKey: "user") as! NSDictionary

                        let userId = user.value(forKey: "id") as! Int
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        let Name = user.value(forKey: "name") as! String

                    //    saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        self.defaultValues.set(Name, forKey: "Name")

                        let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
                        self.navigationController?.pushViewController(profileViewController, animated: true)

                        self.dismiss(animated: false, completion: nil)
                    } else {
                        //error message in case of invalid credential
                        self.labelMessage.text = "Invalid username or password"
                    }
                }
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldUserName.delegate = self
         textFieldPassword.delegate = self
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton

        if defaultValues.string(forKey: "username") != nil{
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewcontroller") as! ProfileViewController
            self.navigationController?.pushViewController(profileViewController, animated: true)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    
}
