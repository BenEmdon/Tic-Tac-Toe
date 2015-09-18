//
//  GameViewController.swift
//  Tic Tac To
//
//  Created by Benjamin Emdon on 2015-05-20.
//  Copyright (c) 2015 Ben Emdon. All rights reserved.
//

import UIKit

class MultiplayerViewController: UIViewController
{
    
    @IBOutlet var playingBoardView: DesignableView!
    
    
    @IBOutlet var ticTacImg1: UIImageView!
    @IBOutlet var ticTacImg2: UIImageView!
    @IBOutlet var ticTacImg3: UIImageView!
    @IBOutlet var ticTacImg4: UIImageView!
    @IBOutlet var ticTacImg5: UIImageView!
    @IBOutlet var ticTacImg6: UIImageView!
    @IBOutlet var ticTacImg7: UIImageView!
    @IBOutlet var ticTacImg8: UIImageView!
    @IBOutlet var ticTacImg9: UIImageView!
    
    @IBOutlet var ticTacButton1: UIButton!
    @IBOutlet var ticTacButton2: UIButton!
    @IBOutlet var ticTacButton3: UIButton!
    @IBOutlet var ticTacButton4: UIButton!
    @IBOutlet var ticTacButton5: UIButton!
    @IBOutlet var ticTacButton6: UIButton!
    @IBOutlet var ticTacButton7: UIButton!
    @IBOutlet var ticTacButton8: UIButton!
    @IBOutlet var ticTacButton9: UIButton!
    
    @IBOutlet var resetButton: UIButton!
    
    @IBOutlet var userMessage: UILabel!
    
    
    @IBOutlet var backButton: DesignableButton!
    
    
    
    var canGoBack = false
    
    var plays = [Int: Int]()
    var done = false
    var aiDeciding = false
    var counter:Int = 0
    
    @IBAction func UIButtonClicked(sender:UIButton)
    {
        if !done
        {
            playingBoardView.scaleX = 0.3
            playingBoardView.scaleY = 0.3
            playingBoardView.animateTo()
            playingBoardView.scaleX = 0.3
            playingBoardView.scaleY = 0.3
            playingBoardView.animate()
        }
        else
        {
            playingBoardView.animation = "flash"
            playingBoardView.duration = 0.1
            playingBoardView.animate()
        }
        
        userMessage.hidden = true
        if plays[sender.tag] == nil && !done
        {
            if counter%2==0
            {
                setImageToSpot(sender.tag, player:1)
                counter++
            }
            else
            {
                setImageToSpot(sender.tag, player:0)
                counter++
            }
        }
        checkForWin()
        
        if !canGoBack
        {
            backButton.hidden = false
            backButton.animation = "slideUp"
            backButton.animate()
        }
        canGoBack = true
    }
    
    
    
    func setImageToSpot(spot:Int, player:Int)
    {
        let playerMark = player == 1 ? "x-icon2" : "o-icon2"
        plays[spot] = player
        switch spot
        {
        case 1:
            ticTacImg1.image = UIImage(named: playerMark)
        case 2:
            ticTacImg2.image = UIImage(named: playerMark)
        case 3:
            ticTacImg3.image = UIImage(named: playerMark)
        case 4:
            ticTacImg4.image = UIImage(named: playerMark)
        case 5:
            ticTacImg5.image = UIImage(named: playerMark)
        case 6:
            ticTacImg6.image = UIImage(named: playerMark)
        case 7:
            ticTacImg7.image = UIImage(named: playerMark)
        case 8:
            ticTacImg8.image = UIImage(named: playerMark)
        case 9:
            ticTacImg9.image = UIImage(named: playerMark)
        default:
            ticTacImg5.image = UIImage(named: playerMark)
        }
    }
    
    @IBAction func resetButtonClicked(sender:UIButton)
    {
        resetButton.hidden = true
        userMessage.hidden = true
        done = false
        reset()
    }
    
    
    func reset()
    {
        plays = [:]
        ticTacImg1.image = nil
        ticTacImg2.image = nil
        ticTacImg3.image = nil
        ticTacImg4.image = nil
        ticTacImg5.image = nil
        ticTacImg6.image = nil
        ticTacImg7.image = nil
        ticTacImg8.image = nil
        ticTacImg9.image = nil
        
        playingBoardView.animation = "slideDown"
        playingBoardView.duration = 1.3
        playingBoardView.opacity = 0
        playingBoardView.animate()
    }
    
    
    func checkForWin()
    {
        var win = false
        let whoWon = ["Red":0,"Blue":1]
        for(key,value) in whoWon
        {
            if  (plays[1] == value && plays[2] == value && plays[3] == value) || //across the top
                (plays[4] == value && plays[5] == value && plays[6] == value) || //across the middle
                (plays[7] == value && plays[8] == value && plays[9] == value) || //across the bottom
                (plays[1] == value && plays[4] == value && plays[7] == value) || //down the left
                (plays[2] == value && plays[5] == value && plays[8] == value) || //down the middle
                (plays[3] == value && plays[6] == value && plays[9] == value) || //down the right
                (plays[1] == value && plays[5] == value && plays[9] == value) || //diag left right
                (plays[3] == value && plays[5] == value && plays[7] == value)//diag right left
            {
                win = true
                userMessage.text = "\(key) won!"
                userMessage.hidden = false
                resetButton.hidden = false
                done = true
            }
            else if allOccupied() && !win
            {
                userMessage.text = "It's a tie!"
                userMessage.hidden = false
                resetButton.hidden = false
                done = true
            }
        }
    }
    
    
    func allOccupied() -> Bool
    {
        for spot in 1...9
        {
            if !isOccupied(spot)
            {
                return false
            }
        }
        return true
    }
    
    
    func isOccupied(spot:Int) -> Bool
    {
        return plays[spot] != nil
    }
    
    //end class
}



