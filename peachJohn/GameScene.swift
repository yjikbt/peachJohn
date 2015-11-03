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
    var bgSoundAction:SKAction!
    
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        
        let ud = NSUserDefaults.standardUserDefaults()
        //名前のデータがないときに初期データをセット
        if ((ud.objectForKey("topGirl") == nil) || (ud.objectForKey("centerGirl") == nil) || (ud.objectForKey("bottomGirl")) == nil){
            ud.setObject("AYA", forKey: "topGirl")
            ud.setObject("YURI", forKey: "centerGirl")
            ud.setObject("MARIKO", forKey: "bottomGirl")
            ud.setObject("", forKey: "touchedName")
        }
        
        if(ud.objectForKey("counter") == nil){
            ud.setObject(1, forKey: "counter")
        }else{
            ud.setObject(2, forKey: "counter")
        }
        
        if(ud.objectForKey("counter") as! Int == 1){
            //最初に出すチュートリアル画面
            self.addIntro()
        }else{
            //2回目の起動時
            self.move()
        }
    }
    
    func move(){
        let topScene:TopScene = TopScene(size:self.size)
        self.view?.presentScene(topScene)
    }
    
    func addIntro(){
        let intro = SKSpriteNode(imageNamed: "intro")
        intro.size = CGSizeMake(sw, sh)
        intro.position = CGPoint(x:sw / 2,y:sh / 2)
        
        self.addChild(intro)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        //画面のどこかをタッチ
        let fadeTransition:SKTransition = SKTransition.fadeWithColor(SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0), duration: 4.0)
        let topScene:TopScene = TopScene(size:self.size)
        // 効果音
        bgSoundAction = SKAction.playSoundFileNamed("bird.mp3", waitForCompletion: false)
        self.runAction(bgSoundAction)
        self.view?.presentScene(topScene, transition: fadeTransition)
    }
}
