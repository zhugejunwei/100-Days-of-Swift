//
//  DropitViewController.swift
//  Dropit
//
//  Created by 诸葛俊伟 on 6/16/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController
{
    @IBOutlet weak var gameView: DropitView! {
        didSet {
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDrop(_:))))
            gameView.addGestureRecognizer(UIPanGestureRecognizer(target: gameView, action: #selector(DropitView.grabDrop(_:))))
            gameView.realGravity = true
        }
    }
    
    func addDrop(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .Ended {
            gameView.addDrop() 
        } 
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        gameView.animating = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        gameView.animating = false
    }
}

    

