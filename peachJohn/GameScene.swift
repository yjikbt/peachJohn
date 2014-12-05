//
//  GameScene.swift
//  peachJohn
//
//  Created by Yuji Ikebata on 10/7/14.
//  Copyright (c) 2014 abisetaoshi. All rights reserved.
//


import SpriteKit

class GameScene: SKScene {
    var rectangle:SKSpriteNode!
    var orange:String = "fc7050"
    var blue:String = "39c3be"
    //time
    override func didMoveToView(view: SKView) {
        //ユーザデフォルト
        let ud = NSUserDefaults.standardUserDefaults()
        var initGirlName:[String] = ["AYA","YURI","TOMOKA"]
        ud.setObject(initGirlName, forKey: "girlNameArray")
        ud.synchronize()
        ud.setObject("", forKey:"touchedName")
        ud.synchronize()
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        //待ち時間
        let titleTime:NSTimeInterval = 1.0
        let iconTime:NSTimeInterval = 2.0
        self.addTitle()
        self.addRectangle()
        self.addStartBtn(titleTime,animationDuration:iconTime)
    }
    
    func addRectangle(){
        // 四角を作成
        rectangle = SKSpriteNode(
            color: UIColor.hexStr("fc7050", alpha: 1.0),
            size: CGSizeMake(80, self.frame.size.height)
        )
        
        let rx = Double(CGRectGetMidX(self.frame)) - 180
        let ry = Double(CGRectGetMidY(self.frame))
        rectangle.position = CGPoint(
            x:rx,
            y:ry
        )
        
        rectangle.name = "rectangle"
        
        self.addChild(rectangle)
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
        startBtn.text = "はじめる"
        startBtn.name = "startBtn"
        startBtn.fontSize = 40
        startBtn.fontColor = UIColor.hexStr(blue, alpha: 1.0)
        startBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:startBtn.frame.size.height * 4)
        
        self.addChild(startBtn)
        
        let wait:SKAction = SKAction.waitForDuration(waitTime)
        let zeroAlpha:SKAction = SKAction.fadeAlphaTo(0, duration: 0)
        let fadeToAlpha1:SKAction = SKAction.fadeAlphaTo(1.0, duration: animationDuration)
        let fadeIn:SKAction = SKAction.sequence([zeroAlpha,wait,fadeToAlpha1])
    }
    
    func addTitle(){
        let title = SKLabelNode(fontNamed:"Franklin Gothic Medium")
        let px = Double(CGRectGetMidX(self.frame)) * 0.9
        let py = Double(CGRectGetMidY(self.frame)) * 1.5
        
        title.text = "FIG"
        title.name = "title"
        title.fontSize = 90
        title.fontColor = UIColor.hexStr(blue, alpha: 1.0)
        
        title.position = CGPoint(x:px,y:py)
        
        self.addChild(title)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            //スタートボタンをタッチ
            if node.name == "startBtn"{
                //トップページに遷移
                let fadeTransition:SKTransition = SKTransition.moveInWithDirection(SKTransitionDirection.Left, duration: 1.0)
                var topScene:TopScene = TopScene(size:self.size)
                self.view?.presentScene(topScene, transition: fadeTransition)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
