//
//  pantyColorModel.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/11.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit

class pantyColorModel: NSObject {
    var pantyColor:UIColor!
    var colorArray = [
        UIColor.hexStr("e55884", alpha: 1.0),
        UIColor.hexStr("e8b8cf", alpha: 1.0),
        UIColor.hexStr("e1b2f8", alpha: 1.0),
        UIColor.hexStr("f8657b", alpha: 1.0),
        UIColor.hexStr("a4f0cf", alpha: 1.0),
        UIColor.hexStr("7fc8b5", alpha: 1.0),
        UIColor.hexStr("abf089", alpha: 1.0),
        UIColor.hexStr("9cf4ef", alpha: 1.0),
        UIColor.hexStr("9ea2f8", alpha: 1.0),
        UIColor.hexStr("98cdb6", alpha: 1.0),
        
        UIColor.hexStr("ab354d", alpha: 1.0),
        UIColor.hexStr("ed3f67", alpha: 1.0),
        UIColor.hexStr("72549a", alpha: 1.0),
        UIColor.hexStr("8f245f", alpha: 1.0),
        UIColor.hexStr("85259e", alpha: 1.0),
        UIColor.hexStr("e50a31", alpha: 1.0),
        UIColor.hexStr("820933", alpha: 1.0),
        UIColor.hexStr("445cef", alpha: 1.0),
        UIColor.hexStr("29355f", alpha: 1.0),
        UIColor.hexStr("212123", alpha: 1.0),
        UIColor.hexStr("45464b", alpha: 1.0),
        UIColor.hexStr("1b1c20", alpha: 1.0),
        UIColor.hexStr("ab354d", alpha: 1.0),
        UIColor.hexStr("262523", alpha: 1.0),
    ]
    
    func getBgColor() -> UIColor{
        return colorArray[getColorIndexNum()]
    }
    
    func getColorIndexNum() -> Int{
        var num:Int = Int(arc4random() % 24)
        
        return num
    }
}

//16進数からUIColorを返す拡張
extension UIColor {
    class func hexStr (var hexStr : NSString, var alpha : CGFloat) -> UIColor {
        hexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: hexStr)
        var color: UInt32 = 0
        if scanner.scanHexInt(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            print("invalid hex string")
            return UIColor.whiteColor();
        }
    }
}