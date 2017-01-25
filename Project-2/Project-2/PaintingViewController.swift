//
//  PaintingViewController.swift
//  project-2
//
//  Created by Dusty Argyle on 2/18/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class PaintingViewController: UIViewController, UIApplicationDelegate {    
    var paintingView: PaintingView {
        return view as! PaintingView
    }
    
    private var paintingConfigurationViewController = PaintingConfigurationViewController()
    
    override func loadView() {
        view = PaintingView()
        paintingView.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        let optionsButton = UIBarButtonItem(title: "Options", style: .Plain, target: self, action: "showPaintingConfigurationController:")
//        let undo = UIBarButtonItem(title: "Undo", style: .Plain, target: self, action: "undoLastStroke:")
//        let redo = UIBarButtonItem(title: "Redo", style: .Plain, target: self, action: "redoLastStroke:")

        //navigationItem.rightBarButtonItems?.append(optionsButton)
        //navigationItem.rightBarButtonItems?.append(undo)
        //navigationItem.rightBarButtonItems?.append(redo)
        navigationItem.rightBarButtonItem = optionsButton

    }
    
    func showPaintingConfigurationController(sender: UIBarButtonItem) {
        possibleChange = true
        self.navigationController?.pushViewController(paintingConfigurationViewController, animated: true)
    }
    
    var swipe: Bool = false
    var firstTouch: CGPoint = CGPointZero
    var stroke: Stroke = Stroke()
    var possibleChange: Bool = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(possibleChange) {
            paintingView.setStrokeConfiguration(paintingConfigurationViewController)
            possibleChange = false
        }
        
        swipe = false
        let touch = touches.first as UITouch?
        if touch != nil  {
            firstTouch = touch!.locationInView(paintingView)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swipe = true
        let touch = touches.first as UITouch?
        if touch != nil  {
            let currentTouch = touch!.locationInView(paintingView)
            drawLine(firstTouch, toHere: currentTouch)
            paintingView.setNeedsDisplay()
            firstTouch = currentTouch
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if !swipe {
            drawLine(firstTouch, toHere: firstTouch)
        }
        paintingView.saveStroke()
        paintingView.setNeedsDisplay()
    }
    
    func drawLine(fromHere: CGPoint, toHere: CGPoint) {
        paintingView.addLine(fromHere, toHere:  toHere)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        paintingView.setNeedsDisplay()
    }
}
