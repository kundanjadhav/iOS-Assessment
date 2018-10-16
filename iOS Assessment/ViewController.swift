//
//  ViewController.swift
//  iOS Assessment
//
//  Created by Kundan Jadhav on 16/10/18.
//  Copyright © 2018 Quick Heal Technologies Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        WebServices.sharedInstance.getArticleList(){
            
            results,error  in
            
            if error != nil{
                print(results)
            }else{
                //// Show error
            }
        }
        
    }

    //// Table view Delegates and Data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier : NSString = "reusableCellID"
        let cell : CustomTableViewCell = self.tableView?.dequeueReusableCell(withIdentifier: cellIdentifier as String, for: indexPath) as! CustomTableViewCell
        
        
        return cell
        
    }
}

