//
//  pantyColorModel.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/11.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit
import Spritekit

class pantyColorModel: NSObject {
    var pantyColor:UIColor!
    var isDarkColor:Bool!
   
    
//    var colorArray:SKColor = [SKColor(red: 200/255.0, 200/255.0, blue: 200.0/255.0, alpha: 1.0)]
    func getColorIndexNum() -> Int{
        var num:Int = Int(arc4random() % 24)
        
        if(num > 10){
            
        }else{
            
        }
        
        return num
    }
}
