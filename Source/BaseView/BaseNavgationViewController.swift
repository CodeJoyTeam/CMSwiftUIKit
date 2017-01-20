//
//  BaseNavgationViewController.swift
//  SwiftTemple
//
//  Created by Fang on 2016/10/24.
//  Copyright © 2016年 yfdyf. All rights reserved.
//

import UIKit

class BaseNavgationViewController: UINavigationController {

    override class func initialize() {
        super.initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CMDefaultTheme.theme.defaultBackgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
