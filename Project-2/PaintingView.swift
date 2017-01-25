//
//  Sample.swift
//  Project 1
//
//  Created by Dusty Argyle on 2/6/16.
//  Copyright © 2016 u0770958. All rights reserved.
//

import UIKit

class PaintingView: UIView {
    
    
    var painting: Painting = Painting()
    
    var currentStroke: Stroke = Stroke()
    
    var imageView: UIImageView!
    
    func setPainting(_painting: Painting)
    {
        painting = _painting
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        backgroundColor = UIColor.whiteColor()
        
        let context: CGContext? = UIGraphicsGetCurrentContext()
        
        // Draw current stroke
        print("-----Current Stroke INFO-------")
        CGContextSetLineWidth(context, CGFloat(currentStroke.width) * UIScreen.mainScreen().scale + 1.0)
        print("-> width: \(currentStroke.width)")
        
        let currentStrokeColor = currentStroke.color
        let color: UIColor = UIColor(red: CGFloat(currentStrokeColor.red)/255.0, green: CGFloat(currentStrokeColor.green)/255.0, blue: CGFloat(currentStrokeColor.blue)/255.0, alpha: 1.0)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        //CGContextSetRGBStrokeColor(context, CGFloat(currentStroke.color.red), CGFloat(currentStroke.color.green), CGFloat(currentStroke.color.blue), 1.0)
        print("-> color: r=\(currentStroke.color.red) g=\(currentStroke.color.green) b=\(currentStroke.color.blue)")
        
        //Check Cap
        if(currentStroke.buttEndCap) {
            CGContextSetLineCap(context, CGLineCap.Butt)
            print("-> cap: butt")
        }
        else if (currentStroke.roundEndCap) {
            CGContextSetLineCap(context, CGLineCap.Round)
            print("-> cap: round")
        }
        else if(currentStroke.projectingEndCap) {
            CGContextSetLineCap(context, CGLineCap.Square)
            print("-> cap: square")
        }
        
        //Check join
        if(currentStroke.miterJoin) {
            CGContextSetLineJoin(context, CGLineJoin.Miter)
            print("-> join: miter")
        }
        else if (currentStroke.roundJoin) {
            CGContextSetLineJoin(context, CGLineJoin.Round)
            print("-> join: round")
        }
        else if(currentStroke.bevelJoin) {
            CGContextSetLineJoin(context, CGLineJoin.Bevel)
            print("-> join: bevel")
        }
        
        if(!currentStroke.points.isEmpty) {
            let initialPoint = currentStroke.points[0]
            CGContextMoveToPoint(context, CGFloat(initialPoint.x)*frame.width, CGFloat(initialPoint.y)*frame.height)
            for currentPoint in currentStroke.points {
                CGContextAddLineToPoint(context, CGFloat(currentPoint.x)*frame.width, CGFloat(currentPoint.y)*frame.height)
                print("--> point (x,y) = (\(currentPoint.x), \(currentPoint.y))")
            }
        }
        CGContextDrawPath(context, CGPathDrawingMode.Stroke)
        
        print("-----/Current Stroke INFO-------")
        
        //Draw painting
        var i: Int = 0
        for stroke in painting.strokes {
            let context: CGContext? = UIGraphicsGetCurrentContext()
            
            print("-----Stroke INFO-------")
            print("-> index: \(i)")
            i = i + 1
            CGContextSetLineWidth(context, CGFloat(stroke.width) * UIScreen.mainScreen().scale + 1.0)
            print("-> width: \(stroke.width)");
            
            let strokeColor = stroke.color
            let color: UIColor = UIColor(red: CGFloat(strokeColor.red)/255.0, green: CGFloat(strokeColor.green)/255.0, blue: CGFloat(strokeColor.blue)/255.0, alpha: 1.0)
            CGContextSetStrokeColorWithColor(context, color.CGColor)
            //CGContextSetRGBStrokeColor(context, CGFloat(stroke.color.red), CGFloat(stroke.color.green), CGFloat(stroke.color.blue), 1.0)
            print("-> color: r=\(stroke.color.red) g=\(stroke.color.green) b=\(stroke.color.blue)")
            
            //Check Cap
            if(stroke.buttEndCap) {
                CGContextSetLineCap(context, CGLineCap.Butt)
                print("-> cap: butt")
            }
            else if (stroke.roundEndCap) {
                CGContextSetLineCap(context, CGLineCap.Round)
                print("-> cap: round")
            }
            else if(stroke.projectingEndCap) {
                CGContextSetLineCap(context, CGLineCap.Square)
                print("-> cap: square")
            }
            
            //Check join
            if(stroke.miterJoin) {
                CGContextSetLineJoin(context, CGLineJoin.Miter)
                print("-> join: miter")
            }
            else if (stroke.roundJoin) {
                CGContextSetLineJoin(context, CGLineJoin.Round)
                print("-> join: round")
            }
            else if(stroke.bevelJoin) {
                CGContextSetLineJoin(context, CGLineJoin.Bevel)
                print("-> join: bevel")
            }
            
            if(!stroke.points.isEmpty) {
                let initialPoint = stroke.points[0]
                CGContextMoveToPoint(context, CGFloat(initialPoint.x)*frame.width, CGFloat(initialPoint.y)*frame.height)
                for point in stroke.points {
                   
                    CGContextAddLineToPoint(context, CGFloat(point.x)*frame.width, CGFloat(point.y)*frame.height)
                    print("--> point (x,y) = (\(point.x), \(point.y))")
                }
            }
            CGContextDrawPath(context, CGPathDrawingMode.Stroke)
            print("-----/Stroke INFO-------")
            
        }
        
        
        
        //imageView = UIImageView(frame: self.frame)
        //imageView.contentMode = UIViewContentMode.ScaleAspectFit
        //contentView.addSubview(imageView)
    }
    
    func addLine(fromHere: CGPoint, toHere: CGPoint) {
        let firstPoint = Point.init(x: Float(fromHere.x/(frame.width)), y: Float(fromHere.y/(frame.height)))
        let secondPoint = Point.init(x: Float(toHere.x/(frame.width)), y: Float(toHere.y/(frame.height)))
        currentStroke.addPoint(firstPoint)
        currentStroke.addPoint(secondPoint)
    }
    
    func saveStroke() {
        
//        let ratio: CGFloat = bounds.width * bounds.height
//        for var i=0; i < currentStroke.points.count; ++i {
//            currentStroke.points[i].x = currentStroke.points[i].x / Double(ratio)
//            currentStroke.points[i].y = currentStroke.points[i].y / Double(ratio)
//        }
        
        
        painting.addStroke(currentStroke)
        
        let c = currentStroke.color
        let joinBevel = currentStroke.bevelJoin
        let joinRound = currentStroke.roundJoin
        let joinMiter = currentStroke.miterJoin
        let capRound = currentStroke.roundEndCap
        let capSquare = currentStroke.projectingEndCap
        let capButt = currentStroke.buttEndCap
        let width = currentStroke.width
        
        currentStroke = Stroke()
        
        currentStroke.color = c
        currentStroke.bevelJoin = joinBevel
        currentStroke.roundJoin = joinRound
        currentStroke.miterJoin = joinMiter
        currentStroke.roundEndCap = capRound
        currentStroke.projectingEndCap = capSquare
        currentStroke.buttEndCap = capButt
        currentStroke.width = width
    }
    
    func setStrokeConfiguration(paintingConfigurationViewController: PaintingConfigurationViewController) {
        
        print("-----CHANGING BRUSH CONFIG-------")
        currentStroke.width = paintingConfigurationViewController.sample.width
        print("-> width: \(currentStroke.width)")
        
        let r = paintingConfigurationViewController.sample.red
        let g = paintingConfigurationViewController.sample.green
        let b = paintingConfigurationViewController.sample.blue
        currentStroke.color = Color.init(red: r, green: g, blue: b)
        print("-> color: r=\(r) g=\(g) b=\(b)")
        
        //Check Cap
        if(paintingConfigurationViewController.sample.buttEndCap) {
            currentStroke.buttEndCap = true
            print("-> cap: butt")
        }
        else if (paintingConfigurationViewController.sample.roundEndCap) {
            currentStroke.roundEndCap = true
            print("-> cap: round")
        }
        else {
            currentStroke.projectingEndCap = true
            print("-> cap: projecting")
        }
        
        //Check join
        if(paintingConfigurationViewController.sample.miterJoin) {
            currentStroke.miterJoin = true
            print("-> join: miter")
        }
        else if (paintingConfigurationViewController.sample.roundJoin) {
            currentStroke.roundJoin = true
            print("-> join: round")
        }
        else {
            currentStroke.bevelJoin = true
            print("-> join: bevel")
        }
        print("-----/CHANGING BRUSH CONFIG-------")
    }
}