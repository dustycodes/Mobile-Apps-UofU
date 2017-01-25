//
//  GameInfoViewController.swift
//  project-3
//
//  Created by Dusty Argyle on 4/3/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController, UIApplicationDelegate, PlayGameDelegate {
    
    // Private Member variables
    private var _gameInfoView: GameInfoView = GameInfoView()
    private var _game: Game = Game()
    var delegate: PlayGameDelegate?
    
    // Accessors
    var gameInfoView: GameInfoView {
        get { return _gameInfoView }
        set { _gameInfoView = newValue }
    }
    
    override func loadView() {
        view = _gameInfoView
    }
    
    override func viewDidLoad() {
        _gameInfoView.delegate = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    func setGame(game: Game) {
        _game = game
        _gameInfoView.game = game
    }
    
    func playGame(game: Game) {
        // roll to gameplay 
        delegate?.playGame(game)
    }
}
