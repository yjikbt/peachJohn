//
//  TopScene.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/09.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation

class TopScene: SKScene {
    var settingBtn:SKSpriteNode!
    var isSetting:Bool = false
    var isMoving:Bool = true
    
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        
        //ユーザデフォルト
        let ud = NSUserDefaults.standardUserDefaults()
        var girlNameArray = ud.arrayForKey("girlNameArray")
        
        //設定ボタンをセット
        addSettingBtn()
        
        //infoボタンをセット
        addInfoBtn()
        //名前をセット
        addGirlName(girlNameArray!)
    }
    
    func addGirlName(girlNameArray:NSArray){
        for var i = 0; i < 3; i++ {
            var cnt:CGFloat = CGFloat(3 - i)
            let girlNameBtn = SKLabelNode(fontNamed:"DINAlternate-Bold")
            //ユーザデフォルトから名前を取得
            girlNameBtn.text = String(girlNameArray[i] as NSString)
            girlNameBtn.name = "girlName" + String(i)
            girlNameBtn.fontSize = 50
            girlNameBtn.fontColor = SKColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.0)
            girlNameBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 0.5 * cnt)
            
            self.addChild(girlNameBtn)
        }
    }
    
    func addInfoBtn(){
        let infoBtn = SKSpriteNode(imageNamed: "cat114")
        infoBtn.size = CGSizeMake(40, 40)
        infoBtn.position = CGPoint(x:350, y:50)
        println(infoBtn.position)
        infoBtn.name = "infoBtn"
        
        self.addChild(infoBtn)
    }
    
    func addSettingBtn(){
        settingBtn = SKSpriteNode(imageNamed: "cat114")
        settingBtn.size = CGSizeMake(100, 100)
        settingBtn.position = CGPoint(x:CGRectGetMaxY(self.frame) - 100, y:CGRectGetMaxY(self.frame) - 50);
        println(settingBtn.position)
        settingBtn.name = "settingBtn"
        
        self.addChild(settingBtn)
    }
    
    func switchSetting(){
        
        if(isSetting){
            isSetting = false
            
            settingBtn.removeAllActions()
            
            
        }else{
            isSetting = true
            
            //回転アニメーション
            let rotate:SKAction = SKAction.rotateByAngle(-0.2, duration: 0.1)
            let loop:SKAction = SKAction.repeatActionForever(rotate)
            settingBtn.runAction(loop)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //タッチする指の本数は任意
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "girlName0" || node.name == "girlName1" || node.name == "girlName2"{//正規表現で判定したいけど、かえって冗長になりそう
                //妄想シーンに移動
                var imagineScene:ImagineScene = ImagineScene(size:self.size)
                
                self.view?.presentScene(imagineScene)
            }else if(node.name == "settingBtn"){
                switchSetting()
                
            }else if(node.name == "infoBtn"){
                //infoシーンに移動
                let revealTransition:SKTransition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 0.5)
                var infoScene:InfoScene = InfoScene(size:self.size)
                
                self.view?.presentScene(infoScene, transition: revealTransition)
                
            }
        }
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        for var i = 0; i < 3; i++ {
            var cnt:CGFloat = CGFloat(3 - i)
            //ゆらぎパラメータ
            var parameter:CGFloat = sin(CGFloat(currentTime) + 30 * CGFloat(i)) / 10
            var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + String(i)) as SKLabelNode
            
            //X軸方向にゆらぎ
            girlNameBtn.position.x += parameter
            
        }
    }
}
