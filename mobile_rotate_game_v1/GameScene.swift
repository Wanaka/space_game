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
    private var Pointer = SKSpriteNode()
    private var Rocket = SKSpriteNode()
    var EnemyTimer = Timer()
    
    override func didMove(to view: SKView) {
        
        EnemyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(Enemies), userInfo: nil, repeats: true)
        
        //Connect the game with the iphone gyro and make rotation of the world happen when iphone has been rotated.
        motionManager.gyroUpdateInterval = 0.017
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            if var myData = data
            {
                if myData.rotationRate.y > 0.2
                {   //Bullet
                    let rotatePointer = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * 0.1), duration: 0.1)
                    self.Pointer.run(rotatePointer)
                    
                    let rotateRocket = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * 0.1), duration: 0.1)
                    self.Rocket.run(rotateRocket)
                    
                    print("> : \(myData.rotationRate.y)")
                }
                
                if myData.rotationRate.y < 0.2
                {   //Bullet
                    let rotatePointer = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * 0.1), duration: 0.1)
                    self.Pointer.run(rotatePointer)
                    
                    let rotateRocket = SKAction.rotate(byAngle:CGFloat(myData.rotationRate.y * 0.1), duration: 0.1)
                    self.Rocket.run(rotateRocket)
                    
                    print("< : \(myData.rotationRate.y)")
                }
            }
        }
        pointerCreate()
        playerCreate()
        
    }
    
    func Rockets(){
        
        Rocket = SKSpriteNode(imageNamed: "Ball")
        
        Rocket.size = CGSize(width: 60, height: 30)
        Rocket.color = UIColor.red
        Rocket.colorBlendFactor = 1.0
        
        Rocket.position = CGPoint(x: Pointer.position.x, y: Pointer.position.y + 90)
        Rocket.physicsBody = SKPhysicsBody(circleOfRadius: Rocket.frame.width/2)
        Rocket.physicsBody?.affectedByGravity = false
        
        Rocket.zPosition = 10
        
        Pointer.addChild(Rocket)
        
        var dx = CGFloat((Pointer.position.x) + Rocket.position.x)
        var dy = CGFloat((Pointer.position.y) + Rocket.position.y)
        
        
        
        let magnitude = sqrt(dx * dx + dy * dy)
        dx /= magnitude
        dy /= magnitude
        let vector = CGVector(dx: 30 * dx, dy: 30 * dy)
        
        Rocket.physicsBody?.applyImpulse(vector)
    }
    
    @objc func Enemies(){
        let Enemy = SKSpriteNode(imageNamed: "Ball")
        Enemy.size = CGSize(width: 40, height: 40)
        Enemy.color = UIColor.gray
        //        Enemy.color = UIColor(red: 0.9, green: 0.1, blue: 0.1, alpha: 1.0)
        Enemy.colorBlendFactor = 1.0
        
        //Random positioning and movement
        let RandomPosNr = arc4random() % 8
        
        switch RandomPosNr{
        case 0: //x: left, y: middle to bottom
            Enemy.position.y = -CGFloat(arc4random_uniform(UInt32(frame.size.height)))
            var PosX = frame.size.width
            Enemy.position.x = -CGFloat(PosX)
            self.addChild(Enemy)
            break
        case 1: //x: left, y: middle to top
            Enemy.position.y = CGFloat(arc4random_uniform(UInt32(frame.size.height)))
            var PosX = frame.size.width
            Enemy.position.x = -CGFloat(PosX)
            self.addChild(Enemy)
            break
        case 2://x: middle to left, y: top
            Enemy.position.x = -CGFloat(arc4random_uniform(UInt32(frame.size.width)))
            var PosY = frame.size.height
            Enemy.position.y = CGFloat(PosY)
            self.addChild(Enemy)
            break
        case 3://x: middle to right, y: top
            Enemy.position.x = CGFloat(arc4random_uniform(UInt32(frame.size.width)))
            var PosY = frame.size.height
            Enemy.position.y = CGFloat(PosY)
            self.addChild(Enemy)
            break
        case 4://x: right, y: middle to top
            Enemy.position.y = CGFloat(arc4random_uniform(UInt32(frame.size.height)))
            var PosX = frame.size.width
            Enemy.position.x = CGFloat(PosX)
            self.addChild(Enemy)
            break
        case 5://x: right, y: middle to bottom
            Enemy.position.y = -CGFloat(arc4random_uniform(UInt32(frame.size.height)))
            var PosX = frame.size.width
            Enemy.position.x = CGFloat(PosX)
            self.addChild(Enemy)
            break
        case 6: //x: middle to right, y: bottom
            Enemy.position.x = CGFloat(arc4random_uniform(UInt32(frame.size.width)))
            var PosY = -frame.size.height
            Enemy.position.y = CGFloat(PosY)
            self.addChild(Enemy)
            break
        case 7: //x: middle to left, y: bottom
            Enemy.position.x = -CGFloat(arc4random_uniform(UInt32(frame.size.width)))
            var PosY = -frame.size.height
            Enemy.position.y = CGFloat(PosY)
            self.addChild(Enemy)
            break
        default:
            break
        }
        Enemy.run(SKAction.move(to: Player.position, duration: 3))
    }
    
    func pointerCreate(){ // Pointer
        self.Pointer = self.childNode(withName: "Pointer") as! SKSpriteNode
        self.Pointer.anchorPoint = CGPoint(x: 0.5, y: 0)
        let spawnLocation = CGPoint(x: 0, y: 0)
        self.Pointer.position = spawnLocation
        self.name = "Pointer"
        self.Pointer.zPosition = 0
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
            let location = t.location(in: self)
            Rockets()
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
