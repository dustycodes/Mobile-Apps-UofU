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
    
    // Games Data singleton
    private var _games = Games.sharedInstance
    
    override func loadView() {
        view = NewGameView()
    }
    
    override func viewDidLoad() {
        newGameView.delegate = self
    }
    
    //private methods
    func createGame(sender:UIButton) {
        let g = newGameView.game
        print("Creating a new game")
        print("->Title: \(g.title)")
        print("->1st: \(g.playerOneName)")
        print("->2nd: \(g.playerTwoName)")
        
        //Add new game to model
        if(!_games.addGame(g)) {
            let alertController = UIAlertController(title: "The game was not created!", message: "Please choose a different name.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            //clear out the created game
            newGameView.clear()
        
            //return to GamesListViewController
            navigationController?.popToRootViewControllerAnimated(true)
        }
    }
}
