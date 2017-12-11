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
    @IBOutlet weak var bottomWall: UIImageView!
    @IBOutlet weak var punch: UIView!
    
    
    var objectBounce: Bounce!
    var sin, cos: Double!
    var aTimer: Timer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        objectBounce = Bounce(ball: punch,
                              left_window: leftWall,
                              right_window: rightWall,
                              top_window: topWall,
                              bottom_window: bottomWall)
        launchAnimation()
    }
    func launchAnimation()
    {
        let degrees: Double = Double(arc4random_uniform(360))
        sin = __sinpi(degrees/180)
        cos = __cospi(degrees/180)
        aTimer = Timer.scheduledTimer(timeInterval: 0.01,
                                      target: self,
                                      selector: #selector(animation),
                                      userInfo: nil,
                                      repeats: true)
    }
    @objc func animation()
    {
        punch.center.x += CGFloat(cos)
        punch.center.y += CGFloat(sin)
        
        sin = objectBounce.returnCosSinAfterTouch(sin: sin, cos: cos)[0]
        cos = objectBounce.returnCosSinAfterTouch(sin: sin, cos: cos)[1]
    }
}

