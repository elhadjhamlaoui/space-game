//
//  GameScene.swift
//  space-war
//
//  Created by Ursule Phrinfo on 26/01/2022.
//  Copyright © 2022 PIERGBE. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var background : SKSpriteNode?
    private var background2 : SKSpriteNode?

    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        self.background = self.childNode(withName: "//background") as? SKSpriteNode
        self.background2 = self.childNode(withName: "//background2") as? SKSpriteNode

        var parallax = SKAction()
        var parallax2 = SKAction()

        
        if let background = self.background {
            background.position = CGPoint(x: 0, y:0)
            background.zPosition = 3
            background.size = CGSize(width:self.frame.size.width, height:self.frame.size.height)
            parallax2 = SKAction.repeatForever(SKAction.move(by: CGVector(dx: -self.frame.size.width, dy: 0), duration: 5))

            background.run(parallax2)


        
        }
        
        if let background2 = self.background2 {
                   background2.position = CGPoint(x: 0, y:0)
                   background2.zPosition = 3
                   background2.size = CGSize(width:self.frame.size.width, height:self.frame.size.height)
                   parallax = SKAction.repeatForever(SKAction.move(by: CGVector(dx: -self.frame.size.width, dy: 0), duration: 5))

                   background2.run(parallax)

            
               
        }
        
        
        
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            if let label = self.label {
                label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            }
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.background!.position = CGPoint(x: self.background!.position.x-2, y: self.background!.position.y)
           if(self.background!.position.x < -self.background!.size.width)
           {
            self.background!.position = CGPoint(x: self.background!.position.x + self.background!.size.width , y: self.background!.position.y)
           }
        
        self.background2!.position = CGPoint(x: self.background2!.position.x-20, y: self.background2!.position.y)
        if(self.background2!.position.x < -self.background2!.size.width)
        {
         self.background2!.position = CGPoint(x: self.background2!.position.x + self.background2!.size.width , y: self.background2!.position.y)
        }
       
        
        
    }
}
