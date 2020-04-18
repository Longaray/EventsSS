//
//  CustomNavigationController.swift
//  EventsSS
//
//  Created by Rodrigo Longaray on 18/04/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//
import UIKit

class CustomNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,
                                                  NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-Bold", size: 20)!]
        self.navigationBar.tintColor = .white

        // Do any additional setup after loading the view.
    }
    
    //Change status bar color
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}

