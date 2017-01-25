//
//  GamesListViewController.swift
//  project-3
//
//  Created by Dusty Argyle on 3/6/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import UIKit

class GamesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, GamesDelegate, PlayGameDelegate, CreateGameDelegate
{
    
    //declare the necessary components for the collection view
    private var collectionView: UICollectionView!
    private var layout: UICollectionViewFlowLayout?
    
    // Singleton datasource
    private var _games = Games.sharedInstance
    
    // Private variables
    var _gameAdded: Bool = false
    var _removeGame: Bool = false
    var newGameViewController: NewGameViewController = NewGameViewController()
    
    override func viewDidLoad()
    {
        //determine how you have the cells to be laid out
        layout = UICollectionViewFlowLayout()
        layout!.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        layout!.itemSize = CGSize(width: self.view.frame.width-20.0, height: self.view.frame.height/16)
        
        //set up everything for the collection view
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout!)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(GameCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionView.self))
        
        collectionView.backgroundColor = UIColor.blackColor()
        
        let addButton = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: "addGame:")
        self.navigationItem.rightBarButtonItem = addButton
        
        
        var title = "Show Joinable"
        if(!_games.getToggle()) {
            title = "Show All"
        }
        let toggleButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: "toggle:")
        self.navigationItem.leftBarButtonItem = toggleButton
        collectionView.reloadData()
        
        //add the collection view to the subview
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    
    func addGame(sender: UIBarButtonItem) {
        // show new game view and add the game
        newGameViewController.delegate = self
        navigationController?.pushViewController(newGameViewController, animated: true)
    }
    
    func toggle(sender: UIBarButtonItem) {
        
        dispatch_async(dispatch_get_main_queue()) {
            self._games.setToggle()
            self._games.refreshGameList()
            self.collectionView.reloadData()
        }

        
        
        if(_games.getToggle()) {
            sender.title = "Show Joinable"
        }
        else {
            sender.title = "Show All"
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return _games.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: GameCell = collectionView.dequeueReusableCellWithReuseIdentifier(NSStringFromClass(UICollectionView.self), forIndexPath: indexPath) as! GameCell


        //get the painting objects
        let game = _games.getGameWithIndex(indexPath.item)
        if(game != nil) {
            cell.drawGame(game)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
            let gameInfoViewController: GameInfoViewController = GameInfoViewController()
            gameInfoViewController.delegate = self
        
            //get correct painting collection
            let game = _games.requestGameWithIndex(indexPath.item)
            gameInfoViewController.setGame(game!)
        
            navigationController?.pushViewController(gameInfoViewController, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        _games.delegate = self
    }
    
    func updateView(index: Int) {
        collectionView.reloadData()
    }
    
    func createGame(name: String, player1: String) {
        _games.startNewGame(name, player1: player1, completion: {
            (playerId, gameId) in
            
            if(playerId != "" && gameId != "") {
                self._games.getGameWithIdentifier(gameId, completion: {
                    (game) in
                    let gameViewController: GameViewController = GameViewController()
                    gameViewController.setGame(game)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        //self.navigationController!.popViewControllerAnimated(true)
                        self.navigationController!.pushViewController(gameViewController, animated: true)
                    }
                })
            }
            })
    }
    
    func playGame(game: Game) {
        // TODO roll to gameplay
        _games.playGame(game, completion: {
            () in
            let gameViewController: GameViewController = GameViewController()
            gameViewController.setGame(game)
            
            dispatch_async(dispatch_get_main_queue()) {
                //self.navigationController!.popViewControllerAnimated(true)
                self.navigationController!.pushViewController(gameViewController, animated: true)
            }
            
        })
    }
}