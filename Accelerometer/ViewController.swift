//
//  ViewController.swift
//  Accelerometer
//
//  Created by Ajay Sharma on 2019-01-08.
//  Copyright © 2019 KubbliesInc. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    var accelerationMagnitude: Double = 0;
    let shapeLayer = CAShapeLayer()

    @IBOutlet weak var accelerationLabel: UILabel!
    @IBOutlet weak var testLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 100, height: 10))
        let cicularPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: CGFloat.pi, endAngle: 3 * CGFloat.pi, clockwise: true)
        //Track Layer
        let trackLayer = CAShapeLayer()
        trackLayer.path = cicularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 15
        trackLayer.lineCap = .round
        trackLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(trackLayer)
        
        // Path Layer
        shapeLayer.path = cicularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 15
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shapeLayer)
        //animateBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data {
                let x = myData.acceleration.x
                let y = myData.acceleration.y
                let z = myData.acceleration.z
                self.accelerationMagnitude = sqrt(x*x + y*y + z*z)
                var baseLineAcceleration = self.accelerationMagnitude - 1
                if baseLineAcceleration < 0 {
                    baseLineAcceleration = 0
                }
                self.accelerationLabel.text = String(round(baseLineAcceleration * 9.81 * 100)) + "\n cm/s\u{00B2}"
                
                self.shapeLayer.strokeEnd = CGFloat((self.accelerationMagnitude - 1) / 2)
                self.testLabel.text = String(self.accelerationMagnitude)
            }
        }
    }
    
    func animateBar() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
}

