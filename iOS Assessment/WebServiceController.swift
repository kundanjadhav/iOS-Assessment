//
//  WebServiceController.swift
//  iOS Assessment
//
//  Created by Kundan Jadhav on 16/10/18.
//  Copyright © 2018 Quick Heal Technologies Ltd. All rights reserved.
//

import Foundation


import UIKit

public class WebServices: NSObject {
    
    let API_KEY = "3dae7e066a9e4120b3525a8056fc2771"
    static let sharedInstance = WebServices()
    
    func getArticleList(completion : @escaping completionHandlerType){
        let url = URL.init(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(API_KEY)")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                    
                    let results = array["results"] as! NSArray
                    
                    completion(results, nil)
                    print(array)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        task.resume()
    }
}
