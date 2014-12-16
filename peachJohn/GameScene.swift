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
//        self.addTitle()
        self.addIntro()
//        self.addRectangle()
        self.addStartBtn(titleTime,animationDuration:iconTime)
    }
    
//    func addRectangle(){
//        // 四角を作成
//        rectangle = SKSpriteNode(
//            color: UIColor.hexStr("fc7050", alpha: 1.0),
//            size: CGSizeMake(80, self.frame.size.height)
//        )
//        
//        let rx = Double(CGRectGetMidX(self.frame)) - 180
//        let ry = Double(CGRectGetMidY(self.frame))
//        rectangle.position = CGPoint(
//            x:rx,
//            y:ry
//        )
//        
//        rectangle.name = "rectangle"
//        
//        self.addChild(rectangle)
//    }
    
    
    func addStartBtn(waitTime:NSTimeInterval,animationDuration:NSTimeInterval){
        let startBtn = SKLabelNode(fontNamed: "ShinGoPro-Medium")
        let sw = UIScreen.mainScreen().bounds.size.width
        let sh = UIScreen.mainScreen().bounds.size.height
        startBtn.text = "はじめる"
        startBtn.name = "startBtn"
        startBtn.fontSize = 40
        startBtn.fontColor = UIColor.hexStr(blue, alpha: 1.0)
        startBtn.position = CGPoint(x:sw * 0.55, y:startBtn.frame.size.height * 4)
        
        self.addChild(startBtn)
        
        let wait:SKAction = SKAction.waitForDuration(waitTime)
        let zeroAlpha:SKAction = SKAction.fadeAlphaTo(0, duration: 0)
        let fadeToAlpha1:SKAction = SKAction.fadeAlphaTo(1.0, duration: animationDuration)
        let fadeIn:SKAction = SKAction.sequence([zeroAlpha,wait,fadeToAlpha1])
    }
    
    func addTitle(){
        let title = SKLabelNode(fontNamed:"FranklinGothic-Medium")
        let px = Double(CGRectGetMidX(self.frame)) * 0.9
        let py = Double(CGRectGetMidY(self.frame)) * 1.5
        
        title.text = "FIG"
        title.name = "title"
        title.fontSize = 90
        title.fontColor = UIColor.hexStr(blue, alpha: 1.0)
        
        title.position = CGPoint(x:px,y:py)
        
        self.addChild(title)
    }
    
    func addIntro(){
        let intro = SKSpriteNode(imageNamed: "intro")
        let sw = UIScreen.mainScreen().bounds.size.width
        let sh = UIScreen.mainScreen().bounds.size.height
        intro.size = CGSizeMake(sw, sh)
        intro.position = CGPoint(x:sw / 2,y:sh / 2)
        self.addChild(intro)
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
