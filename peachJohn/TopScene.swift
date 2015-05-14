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
import AVFoundation

class TopScene: SKScene {
    var settingBtn:SKSpriteNode!
    var isSetting:Bool = false
    var isMoving:Bool = true
    var isEnlarging:Bool = false
    var isTouching:Bool = false
    
    var touchedGirlNameBg:SKSpriteNode!//女の子の名前の背景
    var touchedGirlNameBtn:SKNode!//女の子の名前
    
    //効果音再生用SKActin
    var popSoundAction:SKAction!
    var settingOnSoundAction:SKAction!
    var settingOffSoundAction:SKAction!
    var infoOnSoundAction:SKAction!
    var audioPlayer = AVAudioPlayer()
    //画面サイズ
    let sw = UIScreen.mainScreen().bounds.size.width
    let sh = UIScreen.mainScreen().bounds.size.height
    
    let ud = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = UIColor.hexStr("ffffff", alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        
        //設定ボタンをセット
        addSettingBtn()
        
        //infoボタンをセット
//        addInfoBtn()
        //名前をセット
        addGirlName()
        
        // 効果音
        popSoundAction = SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false)
        settingOnSoundAction = SKAction.playSoundFileNamed("settingOn.wav", waitForCompletion: false)
        settingOffSoundAction = SKAction.playSoundFileNamed("settingOff.wav", waitForCompletion: false)
        infoOnSoundAction = SKAction.playSoundFileNamed("InfoOn.wav", waitForCompletion: false)
        
        //途中で停止するかもしれない効果音
        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("drum", ofType: "wav")!)
        var error:NSError?
        audioPlayer = AVAudioPlayer(contentsOfURL: alertSound, error: &error)
        //リピート再生
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
    }
    
    func addGirlName(){
        for var i = 0; i < 3; i++ {
            var cnt:CGFloat = CGFloat(3 - i)
            var girlNameBtn = SKLabelNode(fontNamed:"DINAlternate-Bold")
            //ユーザデフォルトから名前を取得
            if(i == 0){
                girlNameBtn.text = ud.objectForKey("topGirl") as! String
            }else if(i == 1){
                girlNameBtn.text = ud.objectForKey("centerGirl") as! String
            }else if(i == 2){
                girlNameBtn.text = ud.objectForKey("bottomGirl") as! String
            }
            
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
        let infoBtn = SKSpriteNode(imageNamed: "info")
        infoBtn.size = CGSizeMake(40, 40)
        infoBtn.position = CGPoint(x:infoBtn.size.width, y:50)
        infoBtn.name = "infoBtn"
        self.addChild(infoBtn)
    }
    
    func addSettingBtn(){
        settingBtn = SKSpriteNode(imageNamed: "haguruma")
        settingBtn.size = CGSizeMake(150, 150)
        settingBtn.position = CGPoint(x:sw, y:sh);
        settingBtn.name = "settingBtn"
        self.addChild(settingBtn)
    }
    
    func switchSetting(){
        
        if(isSetting){//設定終了
            isSetting = false
            settingBtn.removeAllActions()
            settingBtn.runAction(settingOffSoundAction)
            for node in self.children{
                //名前ノードを判定
                if node.name == "girlName0" || node.name == "girlName1" || node.name == "girlName2"{
                    //元の大きさに戻す
                    let unscale:SKAction = SKAction.scaleTo(1.0, duration: 0.8)
                    node.removeAllActions()
                    unscale.timingMode = SKActionTimingMode.EaseOut
                    //アクション実行
                    node.runAction(unscale)
                }
            }
        }else{//設定開始
            isSetting = true
            
            //回転アニメーション
            let rotate:SKAction = SKAction.rotateByAngle(-0.2, duration: 0.1)
            let loop:SKAction = SKAction.repeatActionForever(rotate)
            settingBtn.runAction(loop)
            
            //効果音
            settingBtn.runAction(settingOnSoundAction)
            
            let scale:SKAction = SKAction.scaleTo(1.15, duration: 0.8)
            let unscale:SKAction = SKAction.scaleTo(1.0, duration: 0.8)
            let scaleSeq:SKAction = SKAction.sequence([scale,unscale])
            
            let loop2:SKAction = SKAction.repeatActionForever(scaleSeq)
            
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
            let scale:SKAction = SKAction.scaleTo(1.25, duration: 0.15)
            let unscale:SKAction = SKAction.scaleTo(1.0, duration: 0.15)
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
            touchedGirlNameBtn.runAction(popSoundAction)
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
        
        //サウンドの再生位置を最初に戻す
        audioPlayer.currentTime = 0
        //サウンド再生
        audioPlayer.play()
        
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
        let dimming:SKAction = SKAction.colorizeWithColor(SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0), colorBlendFactor: 1.0, duration: 1.0)
        let transitionImagineScene:SKAction = SKAction.runBlock({
            //ユーザデフォルト更新
            let nameLabelText = self.touchedGirlNameBtn as! SKLabelNode
            let ud = NSUserDefaults.standardUserDefaults()
            ud.setObject(nameLabelText.text, forKey: "touchedName")
            
            //妄想シーンに移動
            let fadeTransition:SKTransition = SKTransition.fadeWithColor(SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0), duration: 1.0)
            var imagineScene:ImagineScene = ImagineScene(size:self.size)
            
            //サウンド停止
            self.audioPlayer.stop()
            self.view?.presentScene(imagineScene, transition: fadeTransition)
        })
        
        //ボタンのアクションを設定
        let btnGroup:SKAction = SKAction.group([burn,fadeOut])
        
        //ボタン背景のアクションを設定
        let bgSeq:SKAction = SKAction.sequence([enlarge,dimming,transitionImagineScene])
        
        //サウンドフェードアウト
        soundFadeOut()
        //アクション実行
        doGirlNameAction(btnGroup, bgAction: bgSeq)
    }
    
    func soundFadeOut(){
        while(audioPlayer.volume > 0.08){
            audioPlayer.volume = audioPlayer.volume - 0.01
        }
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        //タッチ開始
        isTouching = true
        
        println("began")
        //タッチする指の本数は任意
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if (touchedNode.name == "girlNameRect0" || touchedNode.name == "girlNameRect1" || touchedNode.name == "girlNameRect2") && (isSetting == false){//正規表現で判定したいけど、かえって冗長になりそう
                //名前の背景エリアをタッチしたときの処理
                
                //タッチした背景から、内包する名前のノードを取得
                var indexStr:String!
                indexStr = touchedNode.name?.componentsSeparatedByString("girlNameRect")[1]
                var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + indexStr) as! SKLabelNode
                
                //ボタンの背景
                touchedGirlNameBg = touchedNode as! SKSpriteNode
                touchedGirlNameBtn = girlNameBtn
                
                //名前に対してアクション実行
                popActions()
            }else if(touchedNode.name == "girlNameRect0" || touchedNode.name == "girlNameRect1" || touchedNode.name == "girlNameRect2") && (isSetting == true){
                //タッチした背景から、内包する名前のノードを取得
                var indexStr:String!
                indexStr = touchedNode.name?.componentsSeparatedByString("girlNameRect")[1]
                var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + indexStr) as! SKLabelNode
                
                //alertコントローラ
                var alertController:UIAlertController = UIAlertController(title: girlNameBtn.text + "を編集中", message: "新しい女の子の名前を入力して下さい", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK",
                    style: .Default,
                    handler:{
                        (aciton:UIAlertAction!) -> Void in
                        //ok押したときの処理
                        let textFields:[UITextField]? = alertController.textFields as! [UITextField]?
                        
                        if textFields != nil{
                            for textField:UITextField in textFields!{
                                //ユーザデフォルトを更新
                                switch indexStr {
                                    case "0":
                                        self.ud.setObject(textField.text, forKey: "topGirl")
                                    case "1":
                                        self.ud.setObject(textField.text, forKey: "centerGirl")
                                    case "2":
                                        self.ud.setObject(textField.text, forKey: "bottomGirl")
                                    default:
                                        break
                                }
                                
                                //表示中の名前を更新
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
                    text.placeholder = "ここに名前を入力"
                })
                
                
                //alertを表示
                currentViewController?.presentViewController(alertController, animated: true, completion: nil)
                
            }else if(touchedNode.name == "infoBtn"){
                //infoシーンに移動
                let revealTransition:SKTransition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration: 0.5)
                var infoScene:InfoScene = InfoScene(size:self.size)
                
                touchedNode.runAction(infoOnSoundAction)
                
                self.view?.presentScene(infoScene, transition: revealTransition)
            }
            
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        //タッチ終了
        isTouching = false
        println("cancel")
        
        for touch in (touches as! Set<UITouch>) {
//        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if(isEnlarging){
                let scale:SKAction = SKAction.scaleTo(1.0, duration: 0.1)
                let fadeIn:SKAction = SKAction.fadeAlphaTo(1.0, duration: 1.0)
                let reduce:SKAction = SKAction.resizeToHeight(140, duration: 0.1)
                let dimming:SKAction = SKAction.colorizeWithColor(self.backgroundColor, colorBlendFactor: 1.0, duration: 0.1)
                
                //ボタン背景のアクションを設定
                let bgGroup:SKAction = SKAction.group([reduce,dimming])
                
                //サウンド停止
                audioPlayer.stop()
                //アクション実行
                doGirlNameAction(scale, bgAction: bgGroup)
                
                //すべてのノードを探索
                for node in self.children{
                    //フェードアウトして消滅
                    node.runAction(fadeIn)
                }
            }
            
            if(touchedNode.name == "settingBtn"){
                switchSetting()
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        for var i = 0; i < 3; i++ {
            var cnt:CGFloat = CGFloat(3 - i)
            //ゆらぎパラメータ
            var parameter:CGFloat = sin(CGFloat(currentTime) + 30 * CGFloat(i)) / 10
            var girlNameBtn: SKLabelNode = childNodeWithName("girlName" + String(i)) as! SKLabelNode
            
            //X軸方向にゆらぎ
            girlNameBtn.position.x += parameter
            
        }
    }
}
