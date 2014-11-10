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
        self.backgroundColor = SKColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 1.0)
        
        var girlName:String = "AYAKA"
        addGirlName(girlName)
        addBackground()
    }
   
    func addGirlName(name:String){
        //女の子の名前をセット
        let girlLabelName = SKLabelNode(fontNamed:"HelveticaNeue")
        girlLabelName.text = name
        girlLabelName.fontSize = 50
        girlLabelName.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        girlLabelName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        addChild(girlLabelName)
        
        let fadeInStart:SKAction = SKAction.fadeInWithDuration(1.5)
        let fadeOut:SKAction = SKAction.fadeOutWithDuration(1.6)
        let changeFontColor:SKAction = SKAction.runBlock(
            {
                girlLabelName.fontColor = SKColor(red: 255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        })
        let fadeInEnd:SKAction = SKAction.fadeInWithDuration(1.5)
        
        let changeFontColorAnimation:SKAction = SKAction.sequence([fadeInStart,fadeOut,changeFontColor,fadeInEnd])
        
        girlLabelName.runAction(changeFontColorAnimation)
        //sprite化
//        let labelTexture:SKTexture = self.view?.textureFromNode(girlLabelName)
//        let spriteNode:SKSpriteNode = SKSpriteNode(texture: labelTexture,size:girlLabelName.frame.size)
//        
//        spriteNode.anchorPoint = CGPointZero
//        spriteNode.position = girlLabelName.frame.origin
//        addChild(spriteNode)
//        
//        
//        let colorAnimation:SKAction = SKAction.colorizeWithColor(SKColor.whiteColor(), colorBlendFactor: 0, duration: 1.0)
//        
//        girlLabelName.runAction(colorAnimation)
        
        
    }
    func addBackground(){
        let SCREEN_WIDTH = self.frame.size.width
        let SCREEN_HEIGHT = self.frame.size.height
        let animationDuration = 1.0
        let bg = SKSpriteNode(color:UIColor.blackColor(),size:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT))
        bg.position = CGPoint(x: CGRectGetMidX(self.frame),y: -SCREEN_HEIGHT / 2)
        
        addChild(bg)
        
        let topPos:CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        let moveToTop:SKAction = SKAction.moveTo(topPos,duration:animationDuration)
        
        //アニメーション実行
        bg.runAction(moveToTop)
    }
}

