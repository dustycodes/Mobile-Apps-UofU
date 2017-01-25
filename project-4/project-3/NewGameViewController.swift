//
//  NewGameViewController.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class NewGameViewController: UIViewController, UIApplicationDelegate, CreateGameDelegate {
    // Private Member variables
    var newGameView: NewGameView {
        return view as! NewGameView
    }
    
    var delegate: CreateGameDelegate?
    
    // Games Data singleton
    private var _games = Games.sharedInstance
    
    override func loadView() {
        view = NewGameView()
        newGameView.delegate = self
    }
    
    override func viewDidLoad() {

    }
    
    //private methods
    func createGame(name: String, player1: String) {
        delegate!.createGame(name, player1: player1)
    }
}
