//
//  Games.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation

class Games {
    
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
    
    // Private collection variables
    private var _games: [Game] = []
    private var _currentGame: Game?
    private var _currentIndex: Int = 0
    
    //contstructor
    // Constructor
    init() {
        _games = readGames()
    }
    
    // Access methods
    var count: Int {
        get { return _games.count }
    }
    
    func getGameWithIndex(gameIndex: Int) -> Game {
        return _games[gameIndex]
    }
    
    func containsGame(game: Game) -> Bool{
        for g in _games {
            if(g.title == game.title) {
                return true
            }
        }
        return false
    }
    
    func readGames() -> [Game] {
        let file = "battleship.txt"
        var gs: [Game] = []
        
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(file)
            
            //reading
            do {
                let fileContent = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                
                // Parse fileContent as JSON
                //print(fileContent)
                if let data = fileContent.dataUsingEncoding(NSUTF8StringEncoding) {
                    do {
                        let json =  try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
                        //print(json)
                        let games: NSArray = NSArray(array: (json?["games"])! as! [AnyObject])
                        //print(games)
                        for game in games {
                            print(game)
                            let g: Game = Game(game: game as! NSDictionary)
                            gs.append(g)
                        }
                        
                    } catch let error as NSError {
                        print(error)
                    }
                }

                //print(json["games"])
                
            }
            catch {/* error handling here */}
        }

        return gs
    }
    
    func saveGames() {
        let file = "battleship.txt"
        
        var text: String = "{ \"games\": ["
        for g in _games {
            text += g.getJSON()
            text += ", "
        }
        text = text.substringToIndex(text.endIndex.predecessor().predecessor())
        text += "] }"
        
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(file);
            
            print(text)
            
            //writing
            do {
                try text.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {/* error handling here */}
        }
    }
    
    // Modification methods
    func addGame(game: Game) -> Bool{
        if(containsGame(game)) {
            return false
        }
        else {
            _games.append(game)
            return true
        }
    }
    
    func removeGameWithIndex(gameIndex: Int) {
        _games.removeAtIndex(gameIndex)
    }
    
    func saveGameWithIndex(gameIndex: Int, game: Game) {
        _games[gameIndex] = game
    }
}