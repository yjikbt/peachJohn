//
//  ImagineScene.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/10.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import SpriteKit

class ImagineScene: SKScene {
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 200/255.0, green: 200/255.0, blue: 200.0/255.0, alpha: 1.0)
        let girlMiddleBtn = SKLabelNode(fontNamed:"HelveticaNeue")
        girlMiddleBtn.text = "AYAKA"
        girlMiddleBtn.name = "girlMiddle"
        girlMiddleBtn.fontSize = 50
        girlMiddleBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        girlMiddleBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        addChild(girlMiddleBtn)
        
        addBackground()
    }
   
    func addBackground(){
        let SCREEN_WIDTH = self.frame.size.width
        let SCREEN_HEIGHT = self.frame.size.height
        let animationDuration = 1.0
        let bg = SKSpriteNode(color:UIColor.greenColor(),size:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT))
        bg.position = CGPoint(x: CGRectGetMidX(self.frame),y: -SCREEN_HEIGHT / 2)
        
        addChild(bg)
        
        let topPos:CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        let moveToTop:SKAction = SKAction.moveTo(topPos,duration:animationDuration)
        
        //アニメーション実行
        bg.runAction(moveToTop)
    }
}

