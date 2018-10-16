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

    
    
    func getArticleList() -> String?  {
        var jsonObject : Data?

            do {
                let jsonString = try String(contentsOf: URL.init(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(API_KEY)")!, encoding: .ascii)
                jsonObject = jsonString.data(using: .utf8)
                
            } catch let error {
                print("Error: \(error)")
            }
            do {
                if let data = jsonObject,
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                    let icons = json["icons"] as? [[String: Any]] {
                    for iconDetails in icons {
                        
                        //    if iconDetails["height"] as? Int
                        if let faviconURL = iconDetails["url"] as? String {
                            return faviconURL
                            
                        }else{
                            return nil
                        }
                    }
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }

        return nil
    }
    
    
}
