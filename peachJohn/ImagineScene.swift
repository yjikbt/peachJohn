//
//  ImagineScene.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/10.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit
import SpriteKit

class ImagineScene: SKScene {
    override func didMoveToView(view: SKView) {
        let girlMiddleBtn = SKLabelNode(fontNamed:"HelveticaNeue")
        girlMiddleBtn.text = "AYAKA"
        girlMiddleBtn.name = "girlMiddle"
        girlMiddleBtn.fontSize = 50
        girlMiddleBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        girlMiddleBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(girlMiddleBtn)
        
    }
   
}
