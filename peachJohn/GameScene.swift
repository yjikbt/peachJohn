//
//  GameScene.swift
//  peachJohn
//
//  Created by Yuji Ikebata on 10/7/14.
//  Copyright (c) 2014 abisetaoshi. All rights reserved.
//


import SpriteKit

class GameScene: SKScene {
    //time
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //ユーザデフォルト
        let ud = NSUserDefaults.standardUserDefaults()
        var initGirlName:[String] = ["AYA","YURI","TOMOKA"]
        ud.setObject(initGirlName, forKey: "girlNameArray")
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        //待ち時間
        let titleTime:NSTimeInterval = 1.0
        let iconTime:NSTimeInterval = 2.0
        self.addTitle(titleTime)
        self.addIcon(titleTime,animationDuration:iconTime)
        self.addMessage(titleTime,animationDuration:iconTime)
        self.addStartBtn(titleTime,animationDuration:iconTime)
        
        //全体を消す
        //時間は適当
        let wait:SKAction = SKAction.waitForDuration(15)
        let fadeAlphaToZero:SKAction = SKAction.fadeAlphaTo(0, duration: 2)
        let fadeOut:SKAction = SKAction.sequence([wait,fadeAlphaToZero])
        self.runAction(fadeOut)
    }
    
    
    func addTitle(animationDuration:NSTimeInterval){
        //タイトル
        let title = SKSpriteNode(imageNamed: "cat114")
        title.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(title)
        let topPos:CGPoint = CGPoint(x:CGRectGetMidX(self.frame), y:self.frame.height - title.size.height);
        let moveToTop:SKAction = SKAction.moveTo(topPos,duration:animationDuration)
        
        //アニメーション実行
        title.runAction(moveToTop)
    }
    
    func addIcon(waitTime:NSTimeInterval,animationDuration:NSTimeInterval){
        let icon = SKSpriteNode(imageNamed: "cat114")
        icon.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) + icon.size.height)
        self.addChild(icon)
        
        let wait:SKAction = SKAction.waitForDuration(waitTime)
        let zeroAlpha:SKAction = SKAction.fadeAlphaTo(0, duration: 0)
        let fadeToAlpha1:SKAction = SKAction.fadeAlphaTo(1.0, duration: animationDuration)
        let fadeIn:SKAction = SKAction.sequence([zeroAlpha,wait,fadeToAlpha1])
        
        icon.runAction(fadeIn)
    }
    
    func addMessage(waitTime:NSTimeInterval,animationDuration:NSTimeInterval){
        //メッセージ1
        let mes = SKSpriteNode(imageNamed: "cat114")
        mes.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - mes.size.height)
        self.addChild(mes)
        
        let wait:SKAction = SKAction.waitForDuration(waitTime)
        let zeroAlpha:SKAction = SKAction.fadeAlphaTo(0, duration: 0)
        let fadeIn:SKAction = SKAction.fadeAlphaTo(1.0, duration: animationDuration)
        let fadeOut:SKAction = SKAction.fadeAlphaTo(0, duration: animationDuration)
        let fadeInOut:SKAction = SKAction.sequence([zeroAlpha,wait,fadeIn,fadeOut])
        
        mes.runAction(fadeInOut)
        
        //メッセージ2
        let mes2 = SKSpriteNode(imageNamed: "mono_cat.jpeg")
        mes2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - mes2.size.height)
        self.addChild(mes2)
        
        let wait2:SKAction = SKAction.waitForDuration(waitTime + animationDuration * 2 + waitTime)
        let fadeInOut2:SKAction = SKAction.sequence([zeroAlpha,wait2,fadeIn,fadeOut])
        mes2.runAction(fadeInOut2)
        
        //メッセージ3
        let mes3 = SKSpriteNode(imageNamed: "purple_cat.jpeg")
        mes3.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - mes3.size.height)
        self.addChild(mes3)
        
        let wait3:SKAction = SKAction.waitForDuration(waitTime + (animationDuration * 2 + waitTime) * 2)
        
        let transitionTopScene:SKAction = SKAction.runBlock({
            //トップページに遷移
            let fadeTransition:SKTransition = SKTransition.fadeWithColor(self.backgroundColor, duration: 6.0)
            var topScene:TopScene = TopScene(size:self.size)
            self.view?.presentScene(topScene, transition: fadeTransition)
        })
        
        let fadeInOut3:SKAction = SKAction.sequence([zeroAlpha,wait3,fadeIn,fadeOut,transitionTopScene])
        mes3.runAction(fadeInOut3)
    }
    
    func addStartBtn(waitTime:NSTimeInterval,animationDuration:NSTimeInterval){
        let startBtn = SKLabelNode(fontNamed:"HelveticaNeue")
        startBtn.text = "start"
        startBtn.name = "startBtn"
        startBtn.fontSize = 50
        startBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        startBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:startBtn.frame.size.height * 2)
        
        self.addChild(startBtn)
        
        let wait:SKAction = SKAction.waitForDuration(waitTime)
        let zeroAlpha:SKAction = SKAction.fadeAlphaTo(0, duration: 0)
        let fadeToAlpha1:SKAction = SKAction.fadeAlphaTo(1.0, duration: animationDuration)
        let fadeIn:SKAction = SKAction.sequence([zeroAlpha,wait,fadeToAlpha1])
        
        startBtn.runAction(fadeIn)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            //スタートボタンをタッチ
            if node.name == "startBtn"{
                //トップページに遷移
                let fadeTransition:SKTransition = SKTransition.fadeWithColor(self.backgroundColor, duration: 6.0)
                var topScene:TopScene = TopScene(size:self.size)
                self.view?.presentScene(topScene, transition: fadeTransition)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
