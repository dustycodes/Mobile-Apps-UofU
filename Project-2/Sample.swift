//
//  Sample.swift
//  Project 1
//
//  Created by Dusty Argyle on 2/6/16.
//  Copyright © 2016 u0770958. All rights reserved.
//

import UIKit

class Sample: UIView {
    
    private var _scale: CGFloat = UIScreen.mainScreen().scale
    private var _width: Float = 1.0
    
    var width: Float {
        get { return _width }
        set {
            _width = newValue/5.0
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _green: Int = 0
    
    var green: Int {
        get { return _green }
        set {
            _green = newValue
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _red: Int = 0
    
    var red: Int {
        get { return _red }
        set {
            _red = newValue
            print(_red)
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _blue: Int = 0
    
    var blue: Int {
        get { return _blue }
        set {
            _blue = newValue
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    
    
    private var _buttEndCap: Bool = true
    
    var buttEndCap: Bool {
        get { return _buttEndCap }
        set {
            
            _buttEndCap = newValue
            
            if(newValue) {
                
                _projectingEndCap = false
                _roundEndCap = false
            }
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _roundEndCap: Bool = false
    
    var roundEndCap: Bool {
        get { return _roundEndCap }
        set {
            _roundEndCap = newValue
            if(newValue) {
                
                _buttEndCap = false
                _projectingEndCap = false
            }
            
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _projectingEndCap: Bool = false
    
    var projectingEndCap: Bool {
        get { return _projectingEndCap }
        set {
            
            _projectingEndCap = newValue
            if(newValue) {
                
                _buttEndCap = false
                _roundEndCap = false
            }
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _miterJoin: Bool = true
    
    var miterJoin: Bool {
        get { return _miterJoin }
        set {
            _miterJoin = newValue
            
            if(newValue) {
                
                _roundJoin = false
                _bevelJoin = false
            }
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _roundJoin: Bool = false
    
    var roundJoin: Bool {
        get { return _roundJoin }
        set {
            _roundJoin = newValue
            if(newValue) {
                
                _miterJoin = false
                _bevelJoin = false
            }
            
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    private var _bevelJoin: Bool = false
    
    var bevelJoin: Bool {
        get { return _bevelJoin }
        set {
            _bevelJoin = newValue
            
            if(newValue) {
                
                _roundJoin = false
                _miterJoin = false
            }
            
            
            //redraw the line
            setNeedsDisplay() //at the next appropriate time, draw the display
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        CGContextMoveToPoint(context, self.bounds.width/4, self.bounds.height/8)
        CGContextAddLineToPoint(context, 3*self.bounds.width/4, self.bounds.height/2)
        CGContextAddLineToPoint(context, self.bounds.width/4, self.bounds.height/2)
        CGContextAddLineToPoint(context, 3*self.bounds.width/4, 7*self.bounds.height/8)
        CGContextSetLineWidth(context, CGFloat(_width) * _scale + 1.0)
        
        let color: UIColor = UIColor(red: CGFloat(_red)/255.0, green: CGFloat(_green)/255.0, blue: CGFloat(_blue)/255.0, alpha: 1.0)
        
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        
        //Check Cap
        if(_buttEndCap) {
            CGContextSetLineCap(context, CGLineCap.Butt)
            //CGContextsetLineJoin
        }
        else if (_roundEndCap) {
            CGContextSetLineCap(context, CGLineCap.Round)
        }
        else if(_projectingEndCap) {
            CGContextSetLineCap(context, CGLineCap.Square)
        }
        
        //Check join
        if(_miterJoin) {
            CGContextSetLineJoin(context, CGLineJoin.Miter)
        }
        else if (_roundJoin) {
            CGContextSetLineJoin(context, CGLineJoin.Round)
        }
        else if(_bevelJoin) {
            CGContextSetLineJoin(context, CGLineJoin.Bevel)
        }
        
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
    }
}
