//
//  ViewController.swift
//  iOS Assessment
//
//  Created by Kundan Jadhav on 16/10/18.
//  Copyright © 2018 Quick Heal Technologies Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        WebServices.sharedInstance.getArticleList()
        
    }


}

