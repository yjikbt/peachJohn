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
        self.backgroundColor = SKColor(red: 200/255.0, green: 200/255.0, blue: 200.0/255.0, alpha: 1.0)
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
            girlNameBtn.name = "girlTop"
            girlNameBtn.fontSize = 50
            girlNameBtn.fontColor = SKColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
            girlNameBtn.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) * 0.5 * cnt)
            
            self.addChild(girlNameBtn)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            
            if node.name == "girlTop"{
                //妄想シーンに移動
                let push:SKTransition = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 0.5)
                var imagineScene:ImagineScene = ImagineScene(size:self.size)
                imagineScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.view?.presentScene(imagineScene,transition: push)
            }
        }
        
    }
}
