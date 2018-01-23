//
//  ProfileViewController.swift
//  LoginTest
//
//  Created by Tsuneo Ootoshi on 2018/01/23.
//  Copyright © 2018年 Tsuneo Ootoshi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    
    //get shops data
    private var shops = [Shops]()
    final let url = URL(string:"https://www.goodsystem27.com/getshops.php")

    @IBOutlet weak var labelUserName: UILabel!
    
    @IBAction func buttonLogout(_ sender: Any) {
        
        //removing values from default
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
        
        //switching to login screen
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Logincontroller") as! LoginController
        self.navigationController?.pushViewController(loginViewController, animated: true)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        downloadJason()

        //hiding back button
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        //getting user data from defaults
        let defaultValues = UserDefaults.standard
        if let name = defaultValues.string(forKey: "Name"){
            //setting the name to label
            labelUserName.text = name
        } else {
            
        }
        
    }
    
    func downloadJason(){
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something is wrong")
                return
            }
            print("OK")
            do{
                let decoder = JSONDecoder()
                let downloadedShops = try decoder.decode([Shops].self, from: data)
                self.shops = downloadedShops
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }

            }catch{
                print("something wrong after downloaded")
            }

            }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as? ShopCell else {
            return UITableViewCell() }
        cell.labelShopName.text = shops[indexPath.row].shopName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedIndex = indexPath.row
        performSegue(withIdentifier: "showStamp", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StampViewController {
            destination.shop = shops[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
   

}
