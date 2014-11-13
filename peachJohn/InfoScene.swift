//
//  InfoScene.swift
//  peachJohn
//
//  Created by naoyashiga on 2014/11/14.
//  Copyright (c) 2014年 abisetaoshi. All rights reserved.
//
import SpriteKit

class InfoScene: SKScene {
    override func didMoveToView(view: SKView) {
        //背景
        self.backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        self.scaleMode = SKSceneScaleMode.AspectFill
        
        let mes = SKSpriteNode(imageNamed: "cat114")
        mes.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame) - mes.size.height)
        self.addChild(mes)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let moveInTransition:SKTransition = SKTransition.moveInWithDirection(SKTransitionDirection.Up, duration: 0.5)
        let topScene:TopScene = TopScene(size:self.size)
        
        self.view?.presentScene(topScene, transition: moveInTransition)
        
    }
}

