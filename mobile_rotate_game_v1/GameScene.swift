//
//  GameScene.swift
//  mobile_rotate_game_v1
//
//  Created by Jonas Haag on 2017-11-18.
//  Copyright © 2017 Jonas Haag. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene {
    
    var motionManager = CMMotionManager()
    
    private var Player = SKSpriteNode()
    private var Bullet = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        //Connect the game with the iphone gyro and make rotation of the world happen when iphone has been rotated.
        motionManager.gyroUpdateInterval = 0.017
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data
            {
                if myData.rotationRate.y > 0.2
                {   //Player
//                    let rotatePlayer = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * -0.1), duration: 0.1)
//                    self.Player.run(rotatePlayer)
                    
                    //Bullet
                    let rotateBullet = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * 0.1), duration: 0.1)
                    self.Bullet.run(rotateBullet)
                    print("> : \(myData.rotationRate.y)")
                }
                
                if myData.rotationRate.y < 0.2
                {   //Player
//                    let rotatePlayer = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * -0.1), duration: 0.1)
//                    self.Player.run(rotatePlayer)
                    
                    //Bullet
                    let rotateBullet = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * 0.1), duration: 0.1)
                    self.Bullet.run(rotateBullet)
                     
                    print("< : \(myData.rotationRate.y)")
                }
            }
        }
        bulletCreate()
        playerCreate()
    }
    
    func bulletCreate(){ // Bullet
        self.Bullet = self.childNode(withName: "Bullet") as! SKSpriteNode
        self.Bullet.anchorPoint = CGPoint(x: 0.5, y: 1)
        let spawnLocation = CGPoint(x: 0, y: 0)
        self.Bullet.position = spawnLocation
        self.name = "Bullet"
        self.Bullet.zPosition = 0
    }
    
    func playerCreate(){ //Player
        self.Player = self.childNode(withName: "Player") as! SKSpriteNode
        self.Player.zPosition = 1
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))
           
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self))}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self))
            Player.removeAllActions()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
