//
//  ViewController.swift
//  Tic Tac To
//
//  Created by Benjamin Emdon on 2015-05-20.
//  Copyright (c) 2015 Ben Emdon. 
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var singleplayerButton: DesignableButton!
    @IBOutlet var multiplayerButton: DesignableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }

    override func viewWillAppear(animated: Bool) {
        
        singleplayerButton.animation = "slideRight"
        singleplayerButton.animate()
        multiplayerButton.animation  = "slideLeft"
        multiplayerButton.animate()

    }

}

