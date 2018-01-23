//
//  ViewController.swift
//  LoginTest
//
//  Created by Tsuneo Ootoshi on 2018/01/23.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//
import Alamofire
import UIKit

class ViewController: UIViewController {
    
    let URL_USER_REGISTER = "https://www.goodsystem27.com/registration.php"

    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    
    @IBAction func buttonRegister(_ sender: Any) {
        
        let parameters: Parameters = [
            "username":textFieldUsername.text!,
            "password":textFieldPassword.text!,
            "name":textFieldName.text!,
            "email":textFieldEmail.text!,
            "phone":textFieldPhone.text!
        ]
        
        //Sending http post request
        Alamofire.request(URL_USER_REGISTER, method: .post, parameters: parameters).responseJSON
            {
              response in
                print(response)
                
                if let result = response.result.value {
                    let jasonData = result as! NSDictionary
                    self.labelMessage.text = jasonData.value(forKey: "message") as! String?
                }
        
        }
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

