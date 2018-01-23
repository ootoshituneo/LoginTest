//
//  StampViewController.swift
//  LoginTest
//
//  Created by Tsuneo Ootoshi on 2018/01/23.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//

import UIKit
import Alamofire

class StampViewController: UIViewController {
    
 
    var userEmail : String = ""
    var selectedShopId :  String = ""

    @IBOutlet weak var userName: UILabel!
    
    
    @IBAction func Logout(_ sender: Any) {
    }
    
    var shop : Shops?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         selectedShopId = (shop?.shopId)!
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard

        if let name = defaultValues.string(forKey: "Name"){
            //setting the name to label
            userName.text = name
        }
        
        if let email = defaultValues.string(forKey: "useremail"){
           userEmail = email
        }
        
        let SHOP_SEARCH = "https://www.goodsystem27.com/getstamp.php"
            
            let parameters: Parameters=[
                "useremail":userEmail,
                "shopid":selectedShopId
            ]
            
            Alamofire.request(SHOP_SEARCH, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    print(response)
                    
                    if let result = response.result.value {
                        //let jsonData = result as! NSDictionary
                        let jsonData = result
                        
                        print(jsonData)
                        
                        
                        
                        
                        
//                        if(!(jsonData.value(forKey: "error") as! Bool)){
//
//                            let user = jsonData.value(forKey: "user") as! NSDictionary
//                            let count = user.value(forKey: "stampcount") as! Int
//
//
//
//                        } else {
//                            //error message in case of invalid credential
//                           // self.labelMessage.text = "Invalid username or password"
//                        }
                    }
                    }
            
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
