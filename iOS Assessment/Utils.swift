//
//  Utils.swift
//  iOS Assessment
//
//  Created by Kundan Jadhav on 17/10/18.
//  Copyright © 2018 Quick Heal Technologies Ltd. All rights reserved.
//

import Foundation
import UIKit

public class Utils: NSObject {


    static func showResponseError(viewController : UIViewController,error : String){
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
}
