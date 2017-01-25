//
//  Games.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation

protocol GamesDelegate {
    func updateView(index: Int)
}

class Games {
    var delegate: GamesDelegate?
    
    // - Singleton The singleton, there should only be one collection of games
    class var sharedInstance: Games {
        struct Static {
            static var instance: Games?
        }
        
        if (Static.instance == nil) {
            Static.instance = Games()
        }
        
        return Static.instance!
    }
    
    var currentGameID = ""
    var playerID = ""
    
    // Private collection variables
    private var _gameIdentifierList: [Int:String] = [:]
    //private var _gameIdentifiers: [String]
    private var _games: [String:Game] = [:]
    private var _baseURL: String = "http://battleship.pixio.com/api"
    private var _toggle: Bool = true
    
    // Constructor
    init() {
        refreshGameList()
    }
    
    // Access methods
    var count: Int {
        get {
            //refreshGameList()
            return _gameIdentifierList.keys.count
            //return _gameIdentifiers.count
        }
    }
    
    func getToggle() -> Bool{
        return _toggle
    }
    
    func setToggle() {
        _toggle = !_toggle
    }
    
    func gameState(gameIndex: Int)-> GameState {

        //TODO return the game state
        return .InProgress
    }
    
    func gameName(gameIndex: Int)-> String {
        return "Battleship"
    }
    
    func refreshGameList() {
        _games.removeAll()
        _gameIdentifierList.removeAll()
        let requestURL: String = "\(_baseURL)/games"
        let url: NSURL = NSURL(string: requestURL)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler: {(response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in NSOperationQueue.mainQueue().addOperationWithBlock(
            {
//            [weak self] (response, data, error) in
            
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
            guard let jsonArray = json as? [AnyObject] else  {
                return
            }
            var index: Int = 0
            for obj in jsonArray {
                let id: String = obj["id"] as! String
                let name: String = obj["name"] as! String
                let status: String = obj["status"] as! String
                
                if(self._toggle == true || status == "WAITING") {
                    self._gameIdentifierList[index] = id
                    self._games[id] = Game(id: id, name: name, status: status)
                    self.updateView(index)
                    index += 1
                }
            }
            
        })
        })
    }
    
    func getGameWithIndex(gameIndex: Int) -> Game? {
        let identifier = _gameIdentifierList[gameIndex]!
        return _games[identifier]
    }
    
    func requestGameWithIndex(gameIndex: Int) -> Game? {
        let identifier = _gameIdentifierList[gameIndex]!
        var done = false
        getGameWithIdentifier(identifier, completion: {
            [weak self](game) in
            self?._games[identifier] = game
            done = true
            })
        
        while(!done) {
        }
        
        return _games[identifier]
    }
    
    func getGameWithIdentifier(gameId: String, completion: (game: Game) -> ()) {
        let requestURL: String = "\(_baseURL)/games/\(gameId)"
        let url: NSURL = NSURL(string: requestURL)!
        let request: NSURLRequest = NSURLRequest(URL: url)
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
            
            print(gameJSON)
            
            let player1 = gameJSON["player1"] as! String
            let player2 = gameJSON["player2"] as! String
            let winner = gameJSON["winner"] as! String
            let misslesLaunched = gameJSON["missilesLaunched"] as! Int
            
            self!._games[gameId]?.setInformation(player1, player2: player2, winner: winner, missilesLaunched: misslesLaunched)
            completion(game: self!._games[gameId]!)
            
            })
    }
    
    func startNewGame(name: String, player1: String, completion: (playerId: String, gameId: String) -> ()) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            ]
        let parameters = [
            "gameName": name,
            "playerName": player1
        ]
        let postData = try! NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        
        let requestURL: String = "\(_baseURL)/games"
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
            
            if(self != nil) {
                let gid = gameJSON["gameId"] as! String
                let pid = gameJSON["playerId"] as! String
                print(gid)
                self!._games[gid] = Game(id: gid, name: name, status: "WAITING")
                self!._games[gid]!.player1Id = pid
                completion(playerId: pid, gameId: gid)
            }
            })
    }
    
    func playGame(game: Game, completion: () -> ()) {
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache",
            ]
        let parameters = [
            "playerName": game.player1
        ]
        let postData = try! NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        
        let requestURL: String = "\(_baseURL)/games/\(game.gameSummary.id)/join"
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
                let pid = gameJSON["playerId"] as! String
                game.player1Id = pid
                self!._games[game.gameSummary.id] = game
                print(game.gameSummary.id)
                completion()
            }
            })
    }
    
    func updateView(index: Int) {
        delegate?.updateView(index)
    }
    
    // TODO func delet}
}