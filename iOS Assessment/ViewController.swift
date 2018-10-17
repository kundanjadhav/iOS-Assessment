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
    let imageCache = NSCache<AnyObject, AnyObject>()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    struct Article {
        var title : String
        var author : String
        var source : String
        var date : String
        var url : String
        var imgURL : String?
    }
    
    var articles : [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadArticles()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Refresh Articles")
        self.tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl?.isEnabled = true

        
    }
    
    @objc func refresh(sender:AnyObject)
    {
        //my refresh code here..
       self.loadArticles()
    }

    func loadArticles(){
        if Reachability.isConnectedToNetwork(){
        self.activityIndicator("Loading Articles")
        self.tableView.refreshControl?.beginRefreshing()

        WebServices.sharedInstance.getArticleList(){
            results,error  in
            if error == nil{
                for article in results!{
                    if let articleObj = article as? [String : Any] {
                        print(articleObj)
                        var imgUrl : String?
                        let title = articleObj["title"] as! String
                        let author = articleObj["byline"] as! String
                        let source = articleObj["source"] as! String
                        let date = articleObj["published_date"] as! String
                        let url = articleObj["url"] as! String
                        if let mediaArray =  articleObj["media"] as? NSArray{
                            
                            for imageObj in mediaArray{
                                let mediaData = imageObj as! [String: Any]
                                if let media =  mediaData["media-metadata"] as? NSArray{
                                    
                                    for imageURL in media{
                                        
                                        if let imageDetails = imageURL as? [String: Any],let url = imageDetails["url"] as? String{
                                            imgUrl = url
                                        }
                                    }
                                }
                            }
                        }
                        self.articles.append(Article.init(title: title, author: author, source: source, date: date, url: url, imgURL: imgUrl))
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.effectView.removeFromSuperview()
                    self.tableView.refreshControl?.endRefreshing()

                }
            }else{
                self.effectView.removeFromSuperview()
                self.tableView.refreshControl?.endRefreshing()
                Utils.showResponseError(viewController: self, error: (error?.localizedDescription)!)
            }
        }
        }else{
            print("Internet Connection not Available!")
            Utils.showResponseError(viewController: self, error: "Internet connection not available")
            self.tableView.refreshControl?.endRefreshing()
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
        
        cell.articleTitle.text = self.articles[indexPath.row].title
        cell.articleAuthor.text = self.articles[indexPath.row].author
        cell.articleSource.text = self.articles[indexPath.row].source
        cell.articleDate.text = self.articles[indexPath.row].date
        cell.articleImg.layer.cornerRadius = 8.0
        cell.articleImg.clipsToBounds = true
        
        DispatchQueue.global().async {
            do {
                if let imageFromCache = self.imageCache.object(forKey: self.articles[indexPath.row].imgURL! as AnyObject) as? UIImage {
                    DispatchQueue.main.async(execute: { () -> Void in
                        cell.articleImg.image = imageFromCache
                    })
                }else{
                    if let imageData = try? Data(contentsOf: URL.init(string: self.articles[indexPath.row].imgURL!)!){
                        DispatchQueue.main.async(execute: { () -> Void in
                            if let image = UIImage(data: imageData) {
                                self.imageCache.setObject(image as AnyObject, forKey: self.articles[indexPath.row].imgURL! as AnyObject)
                                
                                cell.articleImg.image = image
                            }
                        })
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.pushWebView(url: self.articles[indexPath.row].url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    
    func pushWebView(url : String){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let articleVC = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailsViewControllerID") as! ArticleDetailsViewController
        articleVC.url = url
        self.navigationController?.pushViewController(articleVC, animated: true)
//        let articleVCNavigation = UINavigationController(rootViewController: articleVC)
    }
    
    func activityIndicator(_ title: String) {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
}

