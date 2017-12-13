//
//  ViewController.swift
//  punchHomophobes
//
//  Created by eleves on 17-12-08.
//  Copyright © 2017 eleves. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var leftWall: UIImageView!
    @IBOutlet weak var topWall: UIImageView!
    @IBOutlet weak var rightWall: UIImageView!
    @IBOutlet weak var bottomWall: UIView!
    @IBOutlet weak var punch: UIView!
    @IBOutlet weak var mover: UIView!
    @IBOutlet weak var enemy: UIView!
    @IBOutlet weak var enemy1: UIView!
    @IBOutlet weak var enemy2: UIView!
    @IBOutlet weak var enemy3: UIView!
    @IBOutlet weak var enemy4: UIView!
    @IBOutlet weak var enemy5: UIView!
    @IBOutlet weak var gameOver: UIView!
    
    var objectBounce: Bounce!
    var sin, cos: Double!
    var aTimer: Timer!
    var arrayOfEnemies: [UIView]!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        objectBounce = Bounce(ball: punch,
                              left_window: leftWall,
                              right_window: rightWall,
                              top_window: topWall,
                              bottom_window: bottomWall)
        arrayOfEnemies = [enemy, enemy1, enemy2, enemy3, enemy4, enemy5]
        launchAnimation()
    }
    func launchAnimation()
    {
        let degrees: Double = Double(arc4random_uniform(360))
        sin = __sinpi(degrees/180)
        cos = __cospi(degrees/180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.005,
                                      target: self,
                                      selector: #selector(animation),
                                      userInfo: nil,
                                      repeats: true)
    }
    @objc func animation()
    {
        punch.center.x += CGFloat(cos)
        punch.center.y += CGFloat(sin)
        
        for e in arrayOfEnemies
        {
            if punch.frame.intersects(e.frame)
            {
                var smallNumber = e.frame.width/2 + 10
                var bigNumber = self.view.frame.width - 10 - e.frame.width/2
                let randomX = arc4random_uniform(UInt32(bigNumber - smallNumber + 1)) + UInt32(smallNumber)
                smallNumber = e.frame.height/2 + 10
                bigNumber = self.view.frame.height - 10 - e.frame.height/2
                let randomY = arc4random_uniform(UInt32(bigNumber - smallNumber + 1)) + UInt32(smallNumber)
                e.center.x = CGFloat(randomX)
                e.center.y = CGFloat(randomY)
                //points += 
            }
        }
        
        if punch.frame.intersects(gameOver.frame)
        {
            aTimer.invalidate()
            aTimer = nil
        }
        sin = objectBounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
        cos = objectBounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        let touch: UITouch = touches.first!
        if touch.view == mover
        {
            mover.center.x = touch.location(in: self.view).x
            bottomWall.center.x = mover.center.x
        }
    }
}
