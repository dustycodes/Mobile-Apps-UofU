//
//  PaintingCollection.swift
//  project-2
//
//  Created by Dusty Argyle on 2/18/16.
//  Copyright © 2016 Dusty Argyle. All rights reserved.
//

import Foundation


class PaintingCollection
{
    //set up the model as a singleton so every view controller will access the same instance of the model
    class var sharedInstance: PaintingCollection{
        struct Static {
            static var instance: PaintingCollection?
        }
        
        if (Static.instance == nil)
        {
            Static.instance = PaintingCollection()
        }
        
        return Static.instance!
    }
    
    private var currentPainting: Painting?
    private var currentIndex: Int = 0
    
    private var _paintings: [Painting] = []
    
    // MARK: - Indexing
    var count: Int {
        get {return _paintings.count }
    }
    
    // MARK: - Element Access
    func paintingWithIndex(paintingIndex: Int) -> Painting {
        //return Painting()
        return _paintings[paintingIndex]
    }
    
    func addPainting(painting: Painting) {
        _paintings.append(painting)
    }
    
    func removePaintingWithIndex(paintingIndex: Int) {
        
    }
    
    func getPaintingAtIndex(index: Int) -> Painting
    {
        currentIndex = index
        return _paintings[index]
    }
    
    func savePaintingWithIndex(paintingIndex: Int, painting: Painting) {
        _paintings[paintingIndex] = painting
    }
    
    // MARK - Filtering and Sorting
    func paintingsByAuthorByDate(author: String) -> [Int] {
        return []
    }

    //persistence
    
}