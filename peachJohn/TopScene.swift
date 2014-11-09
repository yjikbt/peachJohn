//
//  TopScene.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/09.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit
import SpriteKit

class TopScene: SKScene {
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 200/255.0, green: 200/255.0, blue: 200.0/255.0, alpha: 1.0)
        
        let girlTopBtn = SKLabelNode(fontNamed:"HelveticaNeue")
        girlTopBtn.text = "YURI"
        girlTopBtn.name = "girlTop"
        girlTopBtn.fontSize = 50
        girlTopBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        girlTopBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 1.5)
        
        self.addChild(girlTopBtn)
        
        let girlMiddleBtn = SKLabelNode(fontNamed:"HelveticaNeue")
        girlMiddleBtn.text = "AYAKA"
        girlMiddleBtn.name = "girlMiddle"
        girlMiddleBtn.fontSize = 50
        girlMiddleBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        girlMiddleBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(girlMiddleBtn)
        
        let girlBottomBtn = SKLabelNode(fontNamed:"HelveticaNeue")
        girlBottomBtn.text = "AI"
        girlBottomBtn.name = "girlBottom"
        girlBottomBtn.fontSize = 50
        girlBottomBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        girlBottomBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) / 2)
        
        self.addChild(girlBottomBtn)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "girlTop"{
                //妄想シーンに移動
                let push:SKTransition = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.5)
                var imagineScene:ImagineScene = ImagineScene(size:self.size)
                imagineScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.view?.presentScene(imagineScene,transition: push)
            }
        }
        
    }
}
