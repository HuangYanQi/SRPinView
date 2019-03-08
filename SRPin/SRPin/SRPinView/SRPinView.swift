//
//  SRPinView.swift
//  SRPin
//
//  Created by 黄彦棋 on 2019/3/7.
//  Copyright © 2019 Seer. All rights reserved.
//

import UIKit

class SRPinView: UIView {
    
    private var sharpLayer:CAShapeLayer!
    
    @IBOutlet weak var pinHeadView: UIView!
    @IBOutlet weak var pinFootView: UIView!
    @IBOutlet weak var pinHeadInnerView: UIView!
    
    private var _rhythmSmall:UIBezierPath?
    private var _rhythmLarge:UIBezierPath?
    
    private var rhythmSmall:UIBezierPath{
        get{
            if _rhythmSmall == nil {
                configBezier()
            }
            return _rhythmSmall!
        }
    }
    private var rhythmLarge:UIBezierPath{
        get{
            if _rhythmLarge == nil {
                configBezier()
            }
            return _rhythmLarge!
        }
    }
    
    private let themeColor = UIColor(red:0.26, green:0.29, blue:0.38, alpha:1.00)
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setUp()
    }
    
    convenience init(center:CGPoint, width:CGFloat) {
        self.init(origin: CGPoint.init(x: center.x - width / 2.0, y: center.y - width), width: width)
        setUp()
    }
    
    convenience init(pinRootPoint p:CGPoint, width:CGFloat) {
        self.init(origin: CGPoint.init(x: p.x - width / 2.0, y: p.y - width * 2.0 + 3), width: width)
    }
    
    init(origin:CGPoint,width:CGFloat) {
        super.init(frame: CGRect.init(origin: origin, size: CGSize.init(width: width, height: width * 2.0)))
    }
    
    private func setUp() -> Void {
        let bundle = Bundle(for: SRPinView.self)
        let nib    = UINib(nibName: "SRPinView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        clipsToBounds = false
        view.clipsToBounds = clipsToBounds
        pinHeadView.backgroundColor = self.themeColor
        pinHeadInnerView.backgroundColor = UIColor(red:0.31, green:0.77, blue:0.98, alpha:1.00)
        pinFootView.backgroundColor = UIColor(red:0.43, green:0.45, blue:0.51, alpha:1.00)
        
        addSubview(view)
        
        sharpLayer = CAShapeLayer.init()
        sharpLayer.frame = bounds
        sharpLayer.fillColor = themeColor.cgColor
        layer.addSublayer(sharpLayer)
    }
    
    override func draw(_ rect: CGRect) {
        let contextRef = UIGraphicsGetCurrentContext()
        let ringW:CGFloat = 3.6,ringH:CGFloat = 1.2
        let ringRect = CGRect.init(origin: CGPoint.init(x: rect.width / 2.0 - ringW/2.0, y: self.pinFootView.frame.maxY - ringH/2.0), size: CGSize(width: ringW, height: ringH))
    
        UIColor(red:0.65, green:0.67, blue:0.71, alpha:1.00).set()
        contextRef?.setLineWidth(1.0)
        contextRef?.addEllipse(in: ringRect)
        contextRef?.drawPath(using: .stroke)
        contextRef?.fillPath()
        
        pinHeadView.layer.cornerRadius = bounds.width / 2.0
        pinHeadInnerView.layer.cornerRadius = pinHeadInnerView.frame.width / 2.0
        pinHeadInnerView.layer.borderColor = UIColor.white.cgColor
        pinHeadInnerView.layer.borderWidth = 1.0
    }
    
    private func configBezier() -> Void {
        let finalWidth = bounds.width * 1.2
        let center = CGPoint.init(x: bounds.width / 2.0, y: pinFootView.frame.maxY + 1.5)
        
        _rhythmSmall = UIBezierPath.init(arcCenter: center, radius: 0.1, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        _rhythmLarge = UIBezierPath.init(arcCenter: center, radius: finalWidth, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
    }
    
    private func rhythm() -> Void {
        let duration = 0.9
        
        let animation1 = CABasicAnimation.init(keyPath: "path")
        animation1.fromValue = rhythmSmall.cgPath
        animation1.toValue   = rhythmLarge.cgPath
        animation1.duration  = duration
        animation1.fillMode  = .forwards
        animation1.timingFunction = CAMediaTimingFunction.init(name: .easeOut)
        animation1.isRemovedOnCompletion = true
    
        let animation2 = CABasicAnimation.init(keyPath: "opacity")
        animation2.fromValue = 0.98
        animation2.toValue   = 0.01
        animation2.duration  = duration
        animation2.fillMode  = .forwards
        animation2.timingFunction = CAMediaTimingFunction.init(name: .linear)
        animation2.isRemovedOnCompletion = true
        
        sharpLayer.add(animation1, forKey: "Rhythm.path")
        sharpLayer.add(animation2, forKey: "Rhythm.opacity")
    }
    
//    func pinFootPointIn(view v:UIView) -> CGPoint {
//
//    }
    
    func jump(rhythmNeed:Bool) -> Void {
        let hFrame = pinHeadView.frame, fFrame = pinFootView.frame
        let offsetHeight1 = fFrame.height * 0.7
        let offsetHeight2 = fFrame.height * 0.1
        
        let hFrame1 = CGRect.init(origin: CGPoint.init(x: hFrame.origin.x, y: hFrame.origin.y - offsetHeight1), size: hFrame.size)
        let fFrame1 = CGRect.init(x: fFrame.origin.x, y: fFrame.origin.y - offsetHeight1, width: fFrame.width, height: fFrame.height + offsetHeight1)
        
        let hFrame2 = CGRect.init(origin: CGPoint.init(x: hFrame.origin.x, y: hFrame.origin.y - offsetHeight2), size: hFrame.size)
        let fFrame2 = CGRect.init(x: fFrame.origin.x, y: fFrame.origin.y - offsetHeight2, width: fFrame.width, height: fFrame.height * 0.2)
        
        let hFrame3 = CGRect.init(origin: CGPoint.init(x: hFrame.origin.x, y: hFrame.origin.y + fFrame.height * 0.7), size: hFrame.size)
        let fFrame3 = CGRect.init(x: fFrame.origin.x, y: fFrame.origin.y + 0.7 * fFrame.height, width: fFrame.width, height: fFrame.height * 0.3)
        
        UIView.animate(withDuration: 0.1,  delay: 0, options: .curveEaseOut, animations: {
            self.pinHeadView.frame = hFrame1
            self.pinFootView.frame = fFrame1
        }) { (complete) in
            UIView.animate(withDuration: 0.1,  delay: 0, options: .curveLinear, animations: {
                self.pinHeadView.frame = hFrame2
                self.pinFootView.frame = fFrame2
            }, completion: { (complete) in
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                    self.pinHeadView.frame = hFrame3
                    self.pinFootView.frame = fFrame3
                }, completion: {(complete) in
                    UIView.animate(withDuration: 0.12, delay: 0,options: .curveEaseOut, animations: {
                        self.pinHeadView.frame = hFrame
                        self.pinFootView.frame = fFrame
                    }, completion:{(complete) in
                        if rhythmNeed {
                            self.rhythm()
                        }
                    })
                })
            })
        }
    }
}

class RhythmView: UIScrollView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let firstResponder = super.hitTest(point, with: event)
        return firstResponder == self ? nil : firstResponder
    }
}
