//
//  Painting.swift
//  project-2
//
//  Created by Dusty Argyle on 2/18/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation

class Painting  {
    var title: String = ""
    var strokes: [Stroke] = []
    var aspectRatio: Double = 1.0
    
    func addStroke(stroke: Stroke) {
        strokes.append(stroke)
    }
    
}
