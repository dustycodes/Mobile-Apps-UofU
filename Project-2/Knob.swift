//
//  Knob.swift
//  Project 1
//
//  Created by u0770958 on 2/1/16.
//  Copyright © 2016 u0770958. All rights reserved.
//

import UIKit

class Knob:UIControl {
    
    //private var _angle: Double = 0.0 //in radians
    private var _angle: Float = 0 //in radians
    
    var knobRect: CGRect = CGRectZero
    
    var angle: Float {
        get { return _angle }
        set {
            _angle = newValue
            
            //redraw the knob
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    var context: CGContext?
    
    //UIView Overrides
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        context = UIGraphicsGetCurrentContext()
        
        
        knobRect.size.width = bounds.width
        knobRect.size.height = bounds.width
        knobRect.origin.x = 0.0
        knobRect.origin.y = (bounds.height * 0.5 - knobRect.height * 0.5)
        
        CGContextAddEllipseInRect(context, knobRect)
        CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
        CGContextFillPath(context)
        
        let knobRadius: CGFloat = knobRect.width * 0.4
        var nibCenter: CGPoint = CGPointZero
        nibCenter.x = knobRect.midX + knobRadius * CGFloat(cos(_angle))
        nibCenter.y = knobRect.midY + knobRadius * CGFloat(sin(_angle))
        
        var nibRect: CGRect = CGRectZero
        nibRect.size.width = knobRect.width * 0.2
        nibRect.size.height = nibRect.size.width
        nibRect.origin.y = nibCenter.y - nibRect.height * 0.5
        nibRect.origin.x = nibCenter.x - nibRect.width * 0.5
        
        CGContextAddEllipseInRect(context, nibRect)
        CGContextSetFillColorWithColor(context, UIColor.darkGrayColor().CGColor)
        CGContextFillPath(context)
    }
    
    // UIResponder overrides
    /*override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    let touch: UITouch = touches.first!
    let touchPoint: CGPoint = touch.locationInView(self)
    
    //print("touchPoint: (\(touchPoint.x), \(touchPoint.y))")
    
    let touchAngle: Float = atan2f(Float(touchPoint.y - knobRect.origin.y), Float(touchPoint.x - knobRect.origin.x))
    angle = touchAngle
    //print("touchAngleB: \(angle)")
    }*/
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesMoved(touches, withEvent: event)
        
        let touch: UITouch = touches.first!
        let touchPoint: CGPoint = touch.locationInView(self)
        
        
        //print("touchPoint: (\(touchPoint.x), \(touchPoint.y))")
        let touchAngle: Float = atan2f(Float(touchPoint.y - knobRect.midY), Float(touchPoint.x - knobRect.midX))
        angle = touchAngle
        //print("touchAngleM: \(angle)")
        
        sendActionsForControlEvents(UIControlEvents.ValueChanged)
    }
    
    //    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    //        super.touchesEnded(touches, withEvent: event)
    //
    //        let touch: UITouch = touches.first!
    //        let touchPoint: CGPoint = touch.locationInView(self)
    //
    //        //print("touchPointE: (\(touchPoint.x), \(touchPoint.y))")
    //        let touchAngle: Float = atan2f(Float(touchPoint.y - knobRect.origin.y), Float(touchPoint.x - knobRect.origin.x))
    //        angle = touchAngle
    //    }
}