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
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        
        var girlName:String = "AYAKA"
        var pantyColor = SKColor(red: 0, green: 0, blue: 0, alpha: 1.0)
        addGirlName(girlName)
        addBackground(pantyColor)
    }
   
    func addGirlName(name:String){
        //女の子の名前をセット
        let girlLabelName = SKLabelNode(fontNamed:"HelveticaNeue")
        girlLabelName.text = name
        girlLabelName.fontSize = 50
        girlLabelName.fontColor = SKColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.0)
        girlLabelName.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        addChild(girlLabelName)
        
        //文字色を変えるアニメーション
        let fadeInStart:SKAction = SKAction.fadeInWithDuration(1.5)
        let fadeOut:SKAction = SKAction.fadeOutWithDuration(1.6)
        let changeFontColor:SKAction = SKAction.runBlock(
            {
                girlLabelName.fontColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        })
        let fadeInEnd:SKAction = SKAction.fadeInWithDuration(1.5)
        
        let changeFontColorAnimation:SKAction = SKAction.sequence([fadeInStart,fadeOut,changeFontColor,fadeInEnd])
        
        girlLabelName.runAction(changeFontColorAnimation)
    }
    func addBackground(pantyColor:UIColor){
        let SCREEN_WIDTH = self.frame.size.width
        let SCREEN_HEIGHT = self.frame.size.height
        let moveDuration = 6.0
        let fadeOutDuration = 5.0
        let fadeTransitionDuration = 5.5
        
        //背景を設置
        let bg = SKSpriteNode(color:pantyColor,size:CGSizeMake(SCREEN_WIDTH,SCREEN_HEIGHT))
        bg.position = CGPoint(x: CGRectGetMidX(self.frame),y: -SCREEN_HEIGHT / 2)
        
        addChild(bg)
        
        //背景がトップへ上ってくるやつ
        let topPos:CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        let moveToTop:SKAction = SKAction.moveTo(topPos,duration:moveDuration)
        moveToTop.timingMode = SKActionTimingMode.EaseInEaseOut
        
        //フェードアウト
        let fadeOut:SKAction = SKAction.fadeOutWithDuration(fadeOutDuration)
        
        //ホームへ遷移
        let transitionAnimation:SKAction = SKAction.runBlock({
            var topScene:TopScene = TopScene(size:self.size)
            topScene.scaleMode = SKSceneScaleMode.AspectFill
            let fadeTransition:SKTransition = SKTransition.fadeWithColor(SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0), duration: fadeTransitionDuration)
            
            self.view?.presentScene(topScene, transition: fadeTransition)
        })
        
        let changeBackgroundAnimation:SKAction = SKAction.sequence([moveToTop,fadeOut,transitionAnimation])
        
        //アニメーション実行
        bg.runAction(changeBackgroundAnimation)
    }
}

