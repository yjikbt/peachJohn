//
//  TopScene.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/09.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//

import UIKit
import SpriteKit

class TopScene: SKScene {
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        
        //ユーザデフォルト
        let ud = NSUserDefaults.standardUserDefaults()
        var girlNameArray = ud.arrayForKey("girlNameArray")
        
        //名前をセット
        addGirlName(girlNameArray!)
    }
    
    func addGirlName(girlNameArray:NSArray){
        for var i = 0; i < 3; i++ {
            var cnt:CGFloat = CGFloat(3 - i)
            let girlNameBtn = SKLabelNode(fontNamed:"DINAlternate-Bold")
            //ユーザデフォルトから名前を取得
            girlNameBtn.text = String(girlNameArray[i] as NSString)
            girlNameBtn.name = "girlName"
            girlNameBtn.fontSize = 50
            girlNameBtn.fontColor = SKColor(red: 0.28, green: 0.28, blue: 0.28, alpha: 1.0)
            girlNameBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 0.5 * cnt)
            
            self.addChild(girlNameBtn)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        //タッチする指の本数は任意
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "girlName"{
                //妄想シーンに移動
//                let fade:SKTransition = SKTransition.fadeWithDuration(2.0)
                var imagineScene:ImagineScene = ImagineScene(size:self.size)
                
                self.view?.presentScene(imagineScene)
            }
        }
        
    }
}
