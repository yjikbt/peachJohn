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
    
    var touchedGirlNameBg:SKSpriteNode!//女の子の名前の背景
    var touchedGirlNameBtn:SKNode!//女の子の名前
    
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
            var girlNameRect:SKSpriteNode = SKSpriteNode(color: self.backgroundColor,size: CGSizeMake(self.frame.size.width, girlNameBtn.fontSize * 3))
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
        
        if(isSetting){//設定終了
            isSetting = false
            
            settingBtn.removeAllActions()
            for node in self.children{
                //名前ノードを判定
                if node.name == "girlName0" || node.name == "girlName1" || node.name == "girlName2"{
                    let horizontal:SKAction = SKAction.rotateToAngle(0, duration: 0.3)
                    node.removeAllActions()
                    //水平に戻す
                    horizontal.timingMode = SKActionTimingMode.EaseOut
                    //アクション実行
                    node.runAction(horizontal)
                }
            }
        }else{//設定開始
            isSetting = true
            
            //回転アニメーション
            let rotate:SKAction = SKAction.rotateByAngle(-0.2, duration: 0.1)
            let loop:SKAction = SKAction.repeatActionForever(rotate)
            settingBtn.runAction(loop)
            
            //回転角度
            let angle:CGFloat = 0.05
            //回転時間間隔
            let rotateDuration:NSTimeInterval = 0.8
            
            //時計回り
            let clockwise:SKAction = SKAction.rotateToAngle(-angle, duration: rotateDuration)
            //反時計回り
            let counterClockwise:SKAction = SKAction.rotateToAngle(angle, duration: rotateDuration)
            let rotateSeq:SKAction = SKAction.sequence([clockwise,counterClockwise])
            
            let loop2:SKAction = SKAction.repeatActionForever(rotateSeq)
            
            //すべてのノードを探索
            for node in self.children{
                //名前ノードを判定
                if node.name == "girlName0" || node.name == "girlName1" || node.name == "girlName2"{
                    node.removeAllActions()
                    //アクション実行
                    node.runAction(loop2)
                }
            }
        }
    }
    
    func popActions(){
        if(isMoving){
            //ポップアニメーション
            let scale:SKAction = SKAction.scaleTo(1.1, duration: 0.1)
            let unscale:SKAction = SKAction.scaleTo(1.0, duration: 0.1)
            let wait:SKAction = SKAction.waitForDuration(0.2)
            let startEnlarging:SKAction = SKAction.runBlock( {
                //クロージャ?だからselfをつけないと怒られる
                if(self.isTouching){
                    self.isEnlarging = true
                    self.enlargeActions()
                }
            })
            
            let popAction:SKAction = SKAction.sequence([scale,unscale,wait,startEnlarging])
            //アクション実行
            touchedGirlNameBtn.runAction(popAction)
        }
    }
    
    func enlargeActions(){
        let scale:SKAction = SKAction.scaleTo(2.0, duration: 2.0)
        let fadeOut:SKAction = SKAction.fadeAlphaTo(0.5, duration: 2.0)
        let enlarge:SKAction = SKAction.resizeToHeight(CGRectGetHeight(self.frame) / 2, duration: 2.0)
        let whitening:SKAction = SKAction.colorizeWithColor(UIColor.whiteColor(), colorBlendFactor: 1.0, duration: 2.0)
        let nextAction:SKAction = SKAction.runBlock({
            //タッチを止めても、もとには戻れない
            self.isEnlarging = false
            //クロージャなのでselfをつけた
            self.finishActions()
        })
        let disappear:SKAction = SKAction.fadeAlphaTo(0, duration: 0.8)
        
        //ボタンのアクションを設定
        let btnGroup:SKAction = SKAction.group([scale,fadeOut])
        let btnSeq:SKAction = SKAction.sequence([btnGroup,nextAction])
        
        //ボタン背景のアクションを設定
        let bgGroup:SKAction = SKAction.group([enlarge,whitening])
        
        //アクション実行
        doGirlNameAction(btnSeq, bgAction: bgGroup)
        
        //すべてのノードを探索
        for node in self.children{
            //タッチしたボタン,その背景以外
            if node as? SKNode != touchedGirlNameBtn && node as? SKNode != touchedGirlNameBg {
                //フェードアウトして消滅
                node.runAction(disappear)
            }
        }
    }
    
    func finishActions(){
        let enlarge:SKAction = SKAction.resizeToHeight(CGRectGetHeight(self.frame) * 2, duration: 0.5)
        let burn:SKAction = SKAction.scaleTo(10.0, duration: 0.5)
        let fadeOut:SKAction = SKAction.fadeAlphaTo(0, duration: 0.2)
        let dimming:SKAction = SKAction.colorizeWithColor(self.backgroundColor, colorBlendFactor: 1.0, duration: 1.0)
        let transitionImagineScene:SKAction = SKAction.runBlock({
            //ユーザデフォルト更新
            let ud = NSUserDefaults.standardUserDefaults()
            let nameLabelText = self.touchedGirlNameBtn as SKLabelNode
            ud.setObject(nameLabelText.text, forKey: "touchedName")
            //妄想シーンに移動
            let fadeTransition:SKTransition = SKTransition.fadeWithColor(self.backgroundColor, duration: 1.0)
            var imagineScene:ImagineScene = ImagineScene(size:self.size)
            
            self.view?.presentScene(imagineScene, transition: fadeTransition)
        })
        
        //ボタンのアクションを設定
        let btnGroup:SKAction = SKAction.group([burn,fadeOut])
        
        //ボタン背景のアクションを設定
        let bgSeq:SKAction = SKAction.sequence([enlarge,dimming,transitionImagineScene])
        
        //アクション実行
        doGirlNameAction(btnGroup, bgAction: bgSeq)
    }
    
    func doGirlNameAction(btnAction:SKAction,bgAction:SKAction){
        //ボタンのアクションの初期化
        touchedGirlNameBtn.removeAllActions()
        //ボタンのアクション実行
        touchedGirlNameBtn.runAction(btnAction)
        
        //ボタン背景のアクションの初期化
        touchedGirlNameBg.removeAllActions()
        //ボタン背景のアクション実行
        touchedGirlNameBg.runAction(bgAction)
        
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //タッチ開始
        isTouching = true
        //タッチする指の本数は任意
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if (touchedNode.name == "girlNameRect0" || touchedNode.name == "girlNameRect1" || touchedNode.name == "girlNameRect2") && (isSetting == false){//正規表現で判定したいけど、かえって冗長になりそう
                //名前の背景エリアをタッチしたときの処理
                
                //タッチした背景から、内包する名前のノードを取得
                var indexStr:String!
                indexStr = touchedNode.name?.componentsSeparatedByString("girlNameRect")[1]
                var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + indexStr) as SKLabelNode
                
                //ボタンの背景
                touchedGirlNameBg = touchedNode as SKSpriteNode
                touchedGirlNameBtn = girlNameBtn
                
                //名前に対してアクション実行
                popActions()
            }else if(touchedNode.name == "girlNameRect0" || touchedNode.name == "girlNameRect1" || touchedNode.name == "girlNameRect2") && (isSetting == true){
                //タッチした背景から、内包する名前のノードを取得
                var indexStr:String!
                indexStr = touchedNode.name?.componentsSeparatedByString("girlNameRect")[1]
                var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + indexStr) as SKLabelNode
                
                //alertコントローラ
                var alertController:UIAlertController = UIAlertController(title: girlNameBtn.text + "を編集中", message: "新しい女の子の名前を入力して下さい", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK",
                    style: .Default,
                    handler:{
                        (aciton:UIAlertAction!) -> Void in
                        //ok押したときの処理
                        let textFields:[UITextField]? = alertController.textFields as [UITextField]?
                        
                        if textFields != nil{
                            for textField:UITextField in textFields!{
                                //女の子の名前を更新
                                girlNameBtn.text = textField.text
                                
                                //設定終了
                                self.switchSetting()
                            }
                        }
                        
                })
                
                let cancelAction = UIAlertAction(title: "cancel",
                    style: .Default,
                    handler:{
                        (aciton:UIAlertAction!) -> Void in
                        //cancel押したときの処理
                        
                })
                
                //根元にあるview
                let currentViewController : UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController!
                
                
                alertController.addAction(cancelAction)
                alertController.addAction(okAction)
                
                //text field追加
                alertController.addTextFieldWithConfigurationHandler({(text:UITextField!) -> Void in
//                    text.keyboardType = UIKeyboardType.Default
                    text.placeholder = "ここに名前を入力"
                })
                
                
                //alertを表示
                currentViewController?.presentViewController(alertController, animated: true, completion: nil)
                
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
            
            if(isEnlarging){
                let scale:SKAction = SKAction.scaleTo(1.0, duration: 0.1)
                let fadeIn:SKAction = SKAction.fadeAlphaTo(1.0, duration: 1.0)
                let reduce:SKAction = SKAction.resizeToHeight(140, duration: 0.1)
                let dimming:SKAction = SKAction.colorizeWithColor(self.backgroundColor, colorBlendFactor: 1.0, duration: 0.1)
                
                //ボタン背景のアクションを設定
                let bgGroup:SKAction = SKAction.group([reduce,dimming])
                
                //アクション実行
                doGirlNameAction(scale, bgAction: bgGroup)
                
                //すべてのノードを探索
                for node in self.children{
                    //フェードアウトして消滅
                    node.runAction(fadeIn)
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
