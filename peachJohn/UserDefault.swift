//
//  UserDefault.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/12/17.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit

enum figUD: String {
    case topGirl = "AYA"
    case centerGirl = "YURI"
    case bottomGirl = "MARIKO"
    case touchedName = ""
    
    func set(value: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject(value, forKey: self.rawValue)
    }
    
    func get() -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().objectForKey(self.rawValue)
    }
}

