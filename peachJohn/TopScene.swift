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
    var isEnlarging:Bool = false
    var isTouching:Bool = false
    
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
            var girlNameBtn = SKLabelNode(fontNamed:"DINAlternate-Bold")
            //ユーザデフォルトから名前を取得
            girlNameBtn.text = String(girlNameArray[i] as NSString)
            girlNameBtn.name = "girlName" + String(i)
            girlNameBtn.fontSize = 50
            girlNameBtn.fontColor = SKColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.0)
            girlNameBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 0.5 * cnt)
            
            self.addChild(girlNameBtn)
            
            //名前の背景
            var girlNameRect:SKSpriteNode = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(self.frame.size.width, girlNameBtn.fontSize * 3))
            //文字が背景の中央になるように位置を調整
            girlNameRect.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 0.5 * cnt + girlNameBtn.fontSize / 3)
            girlNameRect.name = "girlNameRect" + String(i)
            
            self.addChild(girlNameRect)
            
            
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
    
    func popActions(touchedGirlName:SKNode){
        if(isMoving){
            //ポップアニメーション
            let scale:SKAction = SKAction.scaleTo(1.1, duration: 0.1)
            let unscale:SKAction = SKAction.scaleTo(1.0, duration: 0.1)
            let wait:SKAction = SKAction.waitForDuration(0.2)
            let startEnlarging:SKAction = SKAction.runBlock( {
                //クロージャ?だからselfをつけないと怒られる
                if(self.isTouching){
                    self.isEnlarging = true
                    self.enlargeActions(touchedGirlName)
                }
                
            })
            
            let popAction:SKAction = SKAction.sequence([scale,unscale,wait,startEnlarging])
            
            touchedGirlName.runAction(popAction)
        }
    }
    
    func enlargeActions(touchedGirlName:SKNode){
        let scale:SKAction = SKAction.scaleTo(2.0, duration: 2.0)
        let fadeOut:SKAction = SKAction.fadeAlphaTo(0.5, duration: 2.0)
        let enlarge:SKAction = SKAction.resizeToHeight(CGRectGetHeight(self.frame) / 2, duration: 2.0)
//        let whitening:SKAction = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 2.0)
        
        let enlargeGroup:SKAction = SKAction.group([scale,fadeOut,enlarge])
        
        //アクションの初期化
        touchedGirlName.removeAllActions()
        //アクション実行
        touchedGirlName.runAction(enlargeGroup)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //タッチ開始
        isTouching = true
        //タッチする指の本数は任意
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if touchedNode.name == "girlNameRect0" || touchedNode.name == "girlNameRect1" || touchedNode.name == "girlNameRect2"{//正規表現で判定したいけど、かえって冗長になりそう
                //名前の背景エリアをタッチしたときの処理
                //タッチした背景から、内包する名前のノードを取得
                var indexStr:String!
                indexStr = touchedNode.name?.componentsSeparatedByString("girlNameRect")[1]
                var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + indexStr) as SKLabelNode
                //名前に対してアクション実行
                popActions(girlNameBtn)
                
                //妄想シーンに移動
//                var imagineScene:ImagineScene = ImagineScene(size:self.size)
//                
//                self.view?.presentScene(imagineScene)
            }else if(touchedNode.name == "settingBtn"){
                switchSetting()
                
            }else if(touchedNode.name == "infoBtn"){
                //infoシーンに移動
                let revealTransition:SKTransition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 0.5)
                var infoScene:InfoScene = InfoScene(size:self.size)
                
                self.view?.presentScene(infoScene, transition: revealTransition)
                
            }
        }
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        //タッチ終了
        isTouching = false
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if touchedNode.name == "girlNameRect0" || touchedNode.name == "girlNameRect1" || touchedNode.name == "girlNameRect2"{
                //名前の背景エリアをタッチしたときの処理
                //タッチした背景から、内包する名前のノードを取得
                var indexStr:String!
                indexStr = touchedNode.name?.componentsSeparatedByString("girlNameRect")[1]
                var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + indexStr) as SKLabelNode
                
                
                if(isEnlarging){
                    let scale:SKAction = SKAction.scaleTo(1.0, duration: 0.1)
                    let fadeIn:SKAction = SKAction.fadeAlphaTo(1.0, duration: 0.1)
                    
                    let toSmall:SKAction = SKAction.group([scale,fadeIn])
                    
                    //アクションの初期化
                    girlNameBtn.removeAllActions()
                    //アクション実行
                    girlNameBtn.runAction(toSmall)
                    
                    isEnlarging = false
                }
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
