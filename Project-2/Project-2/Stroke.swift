//
//  Stroke.swift
//  project-2
//
//  Created by Dusty Argyle on 2/20/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation

class Stroke {
    var points: [Point] = []
    
    
    private var _width: Float = 1.0
    var width: Float {
        get { return _width; }
        set {
            _width = newValue
        }
    }
    
    private var _color: Color = Color.init(red: 0, green: 0, blue: 0)
    var color: Color {
        get { return _color }
        set {
            _color = newValue
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
        }
    }
    
    func addPoint(point: Point) {
        points.append(point)
    }
    
    func equals(stroke: Stroke) -> Bool {
        if (stroke.width != width || stroke.color.red != color.red || stroke.color.blue != color.blue || stroke.color.green != color.green || stroke.miterJoin != miterJoin || stroke.roundJoin != roundJoin || stroke.bevelJoin != bevelJoin || stroke.buttEndCap != buttEndCap || stroke.projectingEndCap != projectingEndCap || stroke.roundEndCap != roundEndCap) {
            return false
        } else {
            return true
        }
    }
}

struct Color {
    var red: Int
    var green: Int
    var blue: Int
}

struct Point {
    var x: Float
    var y: Float
}