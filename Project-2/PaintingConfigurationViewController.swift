//
//  PaintingConfigurationViewController.swift
//  project-2
//
//  Created by Dusty Argyle on 2/18/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class PaintingConfigurationViewController: UIViewController, UIApplicationDelegate {
    var brushSlider: UISlider?
    var bValue: Int?
    var rValue: Int?
    var gValue: Int?
    var brushValue: Int?
    var sample: Sample = Sample(frame: CGRectZero)

    var bevelJoinButton: UIButton?
    var roundJoinButton: UIButton?
    var miterJoinButton: UIButton?

    var projectingEndButton: UIButton?
    var buttEndButton: UIButton?
    var roundEndButton: UIButton?
    
    override func viewDidLoad() {
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
        let colorW = width/4
        
        view.backgroundColor = UIColor.blackColor()
        
        let brushSlider: UISlider = UISlider(frame: CGRectMake(50, height - 30, 200, 30))
        brushSlider.addTarget(self, action: "changeBrushSize:", forControlEvents: UIControlEvents.ValueChanged)
        brushSlider.userInteractionEnabled = true
        brushSlider.maximumValue = 50.0;
        brushSlider.minimumValue = 0.5;
        view.addSubview(brushSlider)
        
        let rKnob: Knob = Knob(frame: CGRectMake(20.0, 80.0, colorW, colorW))
        rKnob.backgroundColor = UIColor.redColor()
        rKnob.addTarget(self, action: "rKnobValueChanged:", forControlEvents: .ValueChanged)
        view.addSubview(rKnob)
        
        let bKnob: Knob = Knob(frame: CGRectMake(20.0, 90.0 + rKnob.bounds.height, colorW, colorW))
        bKnob.backgroundColor = UIColor.blueColor()
        bKnob.addTarget(self, action: "bKnobValueChanged:", forControlEvents: .ValueChanged)
        view.addSubview(bKnob)
        
        let gKnob: Knob = Knob(frame: CGRectMake(20.0, 100.0 + rKnob.bounds.height + bKnob.bounds.height, colorW, colorW))
        gKnob.backgroundColor = UIColor.greenColor()
        gKnob.addTarget(self, action: "gKnobValueChanged:", forControlEvents: .ValueChanged)
        view.addSubview(gKnob)
        
        let endCapBackground: UIView = UIView(frame: CGRectMake(width-width/4 - 50.0, 80.0, width/4+30.0, 130.0))
        endCapBackground.backgroundColor = UIColor.darkGrayColor()
        view.addSubview(endCapBackground)
        
        buttEndButton = UIButton(frame: CGRectMake(width-width/4-40, 90.0, width/4 + 10, 25))
        buttEndButton!.backgroundColor = UIColor.blackColor()
        buttEndButton!.addTarget(self, action: "buttEndButtonPressed:", forControlEvents: .TouchUpInside)
        buttEndButton!.setTitle("Butt", forState: UIControlState.Normal)
        buttEndButton!.layer.cornerRadius = 6
        buttEndButton!.clipsToBounds = true
        view.addSubview(buttEndButton!)
        
        roundEndButton = UIButton(frame: CGRectMake(width-width/4-40, 130.0, width/4 + 10, 25))
        roundEndButton!.backgroundColor = UIColor.lightGrayColor()
        roundEndButton!.addTarget(self, action: "roundEndButtonPressed:", forControlEvents: .TouchUpInside)
        roundEndButton!.setTitle("Round", forState: UIControlState.Normal)
        roundEndButton!.layer.cornerRadius = 6
        roundEndButton!.clipsToBounds = true
        view.addSubview(roundEndButton!)
        
        projectingEndButton = UIButton(frame: CGRectMake(width-width/4-40, 170.0, width/4 + 10, 25))
        projectingEndButton!.backgroundColor = UIColor.lightGrayColor()
        projectingEndButton!.addTarget(self, action: "projectingEndButtonPressed:", forControlEvents: .TouchUpInside)
        projectingEndButton!.setTitle("Projecting", forState: UIControlState.Normal)
        projectingEndButton!.layer.cornerRadius = 6
        projectingEndButton!.clipsToBounds = true
        view.addSubview(projectingEndButton!)
        
        //JOINS
        let joinBackground: UIView = UIView(frame: CGRectMake(width-width/4 - 50.0, 220.0, width/4+30.0, 130.0))
        joinBackground.backgroundColor = UIColor.darkGrayColor()
        view.addSubview(joinBackground)
        
        miterJoinButton = UIButton(frame: CGRectMake(width-width/4-40, 230.0, width/4 + 10, 25))
        miterJoinButton!.backgroundColor = UIColor.blackColor()
        miterJoinButton!.addTarget(self, action: "miterJoinButtonPressed:", forControlEvents: .TouchUpInside)
        miterJoinButton!.setTitle("Miter", forState: UIControlState.Normal)
        miterJoinButton!.layer.cornerRadius = 6
        miterJoinButton?.clipsToBounds=true
        view.addSubview(miterJoinButton!)
        
        roundJoinButton = UIButton(frame: CGRectMake(width-width/4-40, 270.0, width/4 + 10, 25))
        roundJoinButton!.backgroundColor = UIColor.lightGrayColor()
        roundJoinButton!.addTarget(self, action: "roundJoinButtonPressed:", forControlEvents: .TouchUpInside)
        roundJoinButton!.setTitle("Round", forState: UIControlState.Normal)
        roundJoinButton!.layer.cornerRadius = 6
        roundJoinButton!.clipsToBounds = true
        view.addSubview(roundJoinButton!)
        
        bevelJoinButton = UIButton(frame: CGRectMake(width-width/4-40, 310.0, width/4 + 10, 25))
        bevelJoinButton!.backgroundColor = UIColor.lightGrayColor()
        bevelJoinButton!.addTarget(self, action: "bevelJoinButtonPressed:", forControlEvents: .TouchUpInside)
        bevelJoinButton!.setTitle("Bevel", forState: UIControlState.Normal)
        bevelJoinButton!.layer.cornerRadius = 6
        bevelJoinButton!.clipsToBounds = true
        view.addSubview(bevelJoinButton!)
        
        //draw a line w/ color
        sample = Sample(frame: CGRectMake(20.0, height - width/3 + 15 - 35, width - 40, width/3 - 20))
        sample.backgroundColor = UIColor.whiteColor()
        view.addSubview(sample)
    }
    
    override func loadView() {
        super.loadView()
    }
    
    func gKnobValueChanged(sender: Knob) {
        let convert: Float = 360/256;
        var angle: Float = sender.angle * Float(180/M_PI);
        
        if (angle < 0) {
            angle += 360
        }
        
        gValue = Int(angle/convert)
        //print("gValue: \(gValue)")
        sample.green = gValue!
    }
    
    func rKnobValueChanged(sender: Knob) {
        let convert: Float = 360/256;
        var angle: Float = sender.angle * Float(180/M_PI);
        
        if (angle < 0) {
            angle += 360
        }
        
        rValue = Int(angle/convert)
        
        //print("rValue: \(rValue)")
        sample.red = rValue!
    }
    
    func bKnobValueChanged(sender: Knob) {
        let convert: Float = 360/256;
        var angle: Float = sender.angle * Float(180/M_PI);
        
        if (angle < 0) {
            angle += 360
        }
        
        bValue = Int(angle/convert)
        //print("bValue: \(bValue)")
        sample.blue = bValue!
    }
    
    func changeBrushSize(sender: UISlider) {
        brushValue = Int(sender.value)
        //print("brushValue: \(brushValue)")
        sample.width = Float(brushValue!)
    }
    
    func buttEndButtonPressed(sender: UIButton) {
        sample.buttEndCap = true
        roundEndButton!.backgroundColor = UIColor.lightGrayColor()
        projectingEndButton!.backgroundColor = UIColor.lightGrayColor()
        buttEndButton!.backgroundColor = UIColor.blackColor()
    }
    
    func roundEndButtonPressed(sender: UIButton) {
        sample.roundEndCap = true
        roundEndButton!.backgroundColor = UIColor.blackColor()
        projectingEndButton!.backgroundColor = UIColor.lightGrayColor()
        buttEndButton!.backgroundColor = UIColor.lightGrayColor()
    }
    
    func projectingEndButtonPressed(sender: UIButton) {
        sample.projectingEndCap = true
        roundEndButton!.backgroundColor = UIColor.lightGrayColor()
        projectingEndButton!.backgroundColor = UIColor.blackColor()
        buttEndButton!.backgroundColor = UIColor.lightGrayColor()
    }
    
    func miterJoinButtonPressed(sender: UIButton) {
        sample.miterJoin = true
        miterJoinButton!.backgroundColor = UIColor.blackColor()
        roundJoinButton!.backgroundColor = UIColor.lightGrayColor()
        bevelJoinButton!.backgroundColor = UIColor.lightGrayColor()
    }
    
    func roundJoinButtonPressed(sender: UIButton) {
        sample.roundJoin = true
        miterJoinButton!.backgroundColor = UIColor.lightGrayColor()
        roundJoinButton!.backgroundColor = UIColor.blackColor()
        bevelJoinButton!.backgroundColor = UIColor.lightGrayColor()
    }
    
    func bevelJoinButtonPressed(sender: UIButton) {
        sample.bevelJoin = true
        miterJoinButton!.backgroundColor = UIColor.lightGrayColor()
        roundJoinButton!.backgroundColor = UIColor.lightGrayColor()
        bevelJoinButton!.backgroundColor = UIColor.blackColor()
    }
}