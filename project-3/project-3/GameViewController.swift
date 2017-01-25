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
    private var _game: Game = Game(gameTitle: "New Game", gamePlayerOneName: "Player 1", gamePlayerTwoName: "Player 2")
    var delegate: SaveGameDelegate?
    
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
    }
    
    func setGame(game: Game) {
        _game = game
        _gameView.game = game
        // TODO reload data
    }
    
    func strikeAttempt(button: UIButton) {
        let coordinate = button.titleLabel!.text
        var hit: String = "Miss..."
        if(_game.strike(coordinate!)) {
            hit = "Hit!"
            
            if(_game.checkWin()) {
                hit = "You win!"
                let actionSheetController: UIAlertController = UIAlertController(title: hit, message: "The game is now complete", preferredStyle: .Alert)
                
                //Create and add the Cancel action
                let cancelAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default) { action -> Void in
                    //Do some stuff
                    self.navigationController?.popToRootViewControllerAnimated(true)
                }
                actionSheetController.addAction(cancelAction)
                
                //Present the AlertController
                self.presentViewController(actionSheetController, animated: true, completion: nil)
            }
        }
        
        let actionSheetController: UIAlertController = UIAlertController(title: hit, message: "Pass the device to the other player!", preferredStyle: .Alert)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Dismiss", style: .Default) { action -> Void in
            //Do some stuff
            self._game.swapPlayers()
            self._gameView.layoutSubviews()
        }
        actionSheetController.addAction(cancelAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        checkSave()
    }
    
    func checkSave() {
        delegate?.checkSave()
    }
}
