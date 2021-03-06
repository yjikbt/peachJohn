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
        backgroundColor = SKColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1.0)
        
        addInfo()
    }
    
    func addInfo(){
        let sw = UIScreen.mainScreen().bounds.size.width
        let sh = UIScreen.mainScreen().bounds.size.height
        let info = SKSpriteNode(imageNamed: "info")
        info.size = CGSizeMake(sw, sh)
        info.position = CGPoint(x:sw / 2,y:sh / 2)
        addChild(info)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let moveInTransition = SKTransition.moveInWithDirection(SKTransitionDirection.Up, duration: 0.5)
        let topScene = TopScene(size:self.size)
        let infoOffSoundAction = SKAction.playSoundFileNamed("InfoOff.wav", waitForCompletion: false)
        runAction(infoOffSoundAction)
                
        view?.presentScene(topScene, transition: moveInTransition)
    }
}