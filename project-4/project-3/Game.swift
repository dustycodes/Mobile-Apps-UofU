//
//  Game.swift
//  project-3
//
//  Created by Dusty Argyle on 4/2/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation

class Game {
    private var _gameSummary: GameSummary = GameSummary.init(id: "", name: "", state: GameState.Waiting)
    private var _player1: String = ""
    private var _player1Id: String = ""
    private var _player2: String = ""
    private var _player2Id: String = ""
    private var _winner: String = "IN PROGRESS"
    private var _misslesLaunched: Int = 0
    private var _player1Board: [AnyObject] = []
    private var _player2Board: [AnyObject] = []
    private var _baseURL: String = "http://battleship.pixio.com/api"
    
    var name: String {
        get {
            return _gameSummary.name
        }
        set {
            _gameSummary.name = newValue
            //TODO update on server
        }
    }
    
    var player1: String {
        get {
            return _player1
        }
        set {
            _player1 = newValue
            //TODO update on server
        }
    }
    
    var player1Id: String {
        get {
            return _player1Id
        }
        set {
            _player1Id = newValue
        }
    }
    
    var player2: String {
        get {
            return _player2
        }
        set {
            _player2 = newValue
            //TODO update on server
        }
    }
    
    var player2Id: String {
        get {
            return _player2Id
        }
        set {
            _player2Id = newValue
        }
    }
    
    var winner: String {
        get {
            return _winner
        }
        set {
            _winner = newValue
            //TODO update on server
        }
    }
    
    var gameSummary: GameSummary {
        get {
            return _gameSummary
        }
        set {
            _gameSummary = newValue
            //TODO update on server
        }
    }
    
    init() {
        
    }
    
    init(id: String, name: String, status: String) {
        _gameSummary.id = id
        _gameSummary.name = name
        switch(status) {
        case "PLAYING":
            _gameSummary.state = .InProgress
        case "DONE":
            _gameSummary.state = .Ended
        default:
            _gameSummary.state = .Waiting
        }
    }
    
    func setInformation(player1: String, player2: String, winner: String, missilesLaunched: Int) {
        _player1 = player1
        _player2 = player2
        _winner = winner
        _misslesLaunched = missilesLaunched
    }
    
    func getBoards(completion: (board1: [AnyObject], board2: [AnyObject])->()) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            ]
        let parameters = [
            "playerId": player1Id
        ]
        let postData = try! NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        
        let requestURL: String = "\(_baseURL)/games/\(gameSummary.id)/board"
        let url: NSURL = NSURL(string: requestURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.HTTPBody = postData
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {
            [weak self] (response, data, error) in
            
            // CHECKS
            if data == nil {
                return
            }
            guard let httpResponse = response as? NSHTTPURLResponse else {
                return
            }
            if(httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 || httpResponse.MIMEType != "application/json") {
                return
            }
            
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
            guard let gameJSON = json as? AnyObject else  {
                return
            }
            
            print(json)
            
            if(self != nil) {
                self!._player1Board = gameJSON["playerBoard"] as! [AnyObject]
                self!._player2Board = gameJSON["opponentBoard"] as! [AnyObject]

                completion(board1: self!._player1Board, board2: self!._player2Board)
            }
            })
    }
    
    func isTurn(completion: (isTurn: Bool, winner: String) -> ()) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            ]
        let parameters = [
            "playerId": player1Id
        ]
        let postData = try! NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        
        let requestURL: String = "\(_baseURL)/games/\(_gameSummary.id)/status"
        let url: NSURL = NSURL(string: requestURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.HTTPBody = postData
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {
            [weak self] (response, data, error) in
            
            // CHECKS
            if data == nil {
                return
            }
            guard let httpResponse = response as? NSHTTPURLResponse else {
                return
            }
            if(httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 || httpResponse.MIMEType != "application/json") {
                return
            }
            
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
            guard let gameJSON = json as? AnyObject else  {
                return
            }
            
            print(json)
            
            if(self != nil) {
                completion(isTurn: gameJSON["isYourTurn"] as! Bool, winner: gameJSON["winner"] as! String)
            }
            })

    }
    
    func launchMissile(pid: String, xPos: Int, yPos: Int, completion: (hit: Bool, sunk: Int)->()) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            ]
        let parameters = [
            "playerId": player1Id,
            "xPos": xPos,
            "yPos": yPos
        ]
        let postData = try! NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        
        let requestURL: String = "\(_baseURL)/games/\(_gameSummary.id)/guess"
        let url: NSURL = NSURL(string: requestURL)!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.HTTPBody = postData
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {
            [weak self] (response, data, error) in
            
            // CHECKS
            if data == nil {
                return
            }
            guard let httpResponse = response as? NSHTTPURLResponse else {
                return
            }
            if(httpResponse.statusCode < 200 || httpResponse.statusCode >= 300 || httpResponse.MIMEType != "application/json") {
                return
            }
            
            let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
            guard let gameJSON = json as? AnyObject else  {
                return
            }
            
            print(json)
            
            if(self != nil) {
                let hit = json["hit"] as! Bool
                let sunk = json["shipSunk"] as! Int
                completion(hit: hit, sunk: sunk)
            }
            })
        
    }
}

enum GameState {
    case Waiting
    case InProgress
    case Ended
}

class GameSummary {
    var id: String = ""
    var name: String = ""
    var state: GameState = GameState.Waiting
    
    init(id: String, name: String, state: GameState) {
        self.id = id
        self.name = name
        self.state = state
    }
}