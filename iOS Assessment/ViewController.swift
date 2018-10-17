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
    
    struct Article {
        var title : String
        var author : String
        var source : String
        var date : String
        var url : String
    }
    
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        WebServices.sharedInstance.getArticleList(){
            
            results,error  in
            
            if error == nil{
                print(results)
                for article in results!{
                    if let articleObj = article as? [String : Any] {
                        print(articleObj)
                        let title = articleObj["title"] as! String
                        let author = articleObj["byline"] as! String
                        let source = articleObj["source"] as! String
                        let date = articleObj["published_date"] as! String
                        let url = articleObj["url"] as! String

                        self.articles.append(Article.init(title: title, author: author, source: source, date: date, url: url))
                    }
                }
                
                self.tableView.reloadData()
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
        return self.articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier : NSString = "reusableCellID"
        let cell : CustomTableViewCell = self.tableView?.dequeueReusableCell(withIdentifier: cellIdentifier as String, for: indexPath) as! CustomTableViewCell
        
        cel
        
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

