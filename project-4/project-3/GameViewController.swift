//
//  GameViewController.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

protocol SaveGameDelegate {
    func checkSave()
}

class GameViewController: UIViewController, UIApplicationDelegate, StrikeDelegate {
    
    // Private Member variables
    private var _gameView: GameView = GameView()
    private var _game: Game = Game()
    
    // Accessors
    var gameView: GameView {
        get { return _gameView }
        set { _gameView = newValue }
    }
    
    override func loadView() {
        view = _gameView
    }
    
    override func viewDidLoad() {
        _gameView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        startTimer()
    }
    
    func setGame(game: Game) {
        _game = game
        _gameView.game = game
    }
    
    func strikeAttempt(pid: String, xPos: Int, yPos: Int, completion: (hit: Bool, sunk: Int)->()) {
        _game.launchMissile(pid, xPos: xPos, yPos: yPos, completion: completion)
    }
    
    func showAlert(title: String, message: String) {
         let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        startTimer()
    }
    
    private var _myTurn = false
    
    func startTimer() {
        let queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)
        dispatch_async(queue, {
            [weak self] () in
            while(true) {
                if(self != nil) {
                    var myTurn = false
                    
                    if(myTurn == false) {
                        
                        var returned = false
                        self!._game.isTurn({ (isTurn, winner) in
                            myTurn = isTurn
                            returned = true
                            
                            if(winner != "IN PROGRESS") {
                                dispatch_async(dispatch_get_main_queue()) {
                                    let alertController = UIAlertController(title: "Winner", message: "\(winner)", preferredStyle: UIAlertControllerStyle.Alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                                    self!.presentViewController(alertController, animated: true, completion: nil)
                                    self!.navigationController?.popToRootViewControllerAnimated(true)
                                }
                            }
                            
                            if(isTurn == true) {
                                dispatch_async(dispatch_get_main_queue()) {

                                    self!._gameView.myTurn = true
                                    self!._gameView.game.gameSummary.state = GameState.InProgress
                                    self!._game.gameSummary.state = GameState.InProgress
                                    self!._gameView.setNeedsLayout()
                                    self!._gameView.setNeedsDisplay()
                                }
                            }
                        })
                        
                        while(returned == false) {   }
                        
                        if(myTurn) {
                            return
                        }
                    }
                }
                else {
                    return
                }
            }
            })
    }
}
