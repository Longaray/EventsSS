//
//  UIView-Ext.swift
//  EventsSS
//
//  Created by rodrigo on 15/03/20.
//  Copyright © 2020 rodrigo. All rights reserved.
//

import UIKit

extension UIView{
    
    func pin(to superview:UIView){
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
    }
}
