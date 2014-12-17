//
//  GameScene.swift
//  peachJohn
//
//  Created by Yuji Ikebata on 10/7/14.
//  Copyright (c) 2014 abisetaoshi. All rights reserved.
//


import SpriteKit

class GameScene: SKScene {
    var blue:String = "39c3be"
    let sw = UIScreen.mainScreen().bounds.size.width
    let sh = UIScreen.mainScreen().bounds.size.height
    
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        
        let ud = NSUserDefaults.standardUserDefaults()
        //名前のデータがないときに初期データをセット
        if ((ud.objectForKey("topGirl") != nil) || (ud.objectForKey("centerGirl") != nil) || (ud.objectForKey("bottomGirl")) != nil){
            ud.setObject("topGirl", forKey: "AYA")
            ud.setObject("centerGirl", forKey: "YURI")
            ud.setObject("bottomGirl", forKey: "MARIKO")
            ud.setObject("touchedName", forKey: "")
        }
        
        self.addIntro()
        self.addStartBtn()
    }
    
    func addStartBtn(){
        let startBtn = SKLabelNode(fontNamed: "ShinGoPro-Medium")
        startBtn.text = "はじめる"
        startBtn.name = "startBtn"
        startBtn.fontSize = 40
        startBtn.fontColor = UIColor.hexStr(blue, alpha: 1.0)
        startBtn.position = CGPoint(x:sw * 0.55, y:startBtn.frame.size.height * 4)
        
        self.addChild(startBtn)
    }
    
    func addIntro(){
        let intro = SKSpriteNode(imageNamed: "intro")
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
                let fadeTransition:SKTransition = SKTransition.fadeWithColor(SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0), duration: 4.0)
                var topScene:TopScene = TopScene(size:self.size)
                self.view?.presentScene(topScene, transition: fadeTransition)
            }
        }
    }
}
