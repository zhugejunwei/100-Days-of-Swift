//
//  BrickViewController.swift
//  Brickout
//
//  Created by 诸葛俊伟 on 6/17/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

class BrickViewController: UIViewController
{
    @IBOutlet weak var gameView: BrickView! {
        didSet {
            gameView.addGestureRecognizer(UITapGestureRecognizer(target: gameView, action: #selector(gameView.startBall(_:))))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gameView.addBoard()
        gameView.addBall()
        gameView.animating = true
    }

}
