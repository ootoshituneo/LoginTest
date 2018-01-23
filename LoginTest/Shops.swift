//
//  Shops.swift
//  LoginTest
//
//  Created by Tsuneo Ootoshi on 2018/01/23.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//

import UIKit

class Shops: Codable {
    let shopName : String
    let phoneNum : String
    let shopId : String
  
    init(shopName : String, phoneNum : String, shopId : String){
        self.shopName = shopName
        self.phoneNum = phoneNum
        self.shopId = shopId
    }
}
