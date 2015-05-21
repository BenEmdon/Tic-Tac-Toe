//
//  GameViewController.swift
//  Tic Tac To
//
//  Created by Benjamin Emdon on 2015-05-20.
//  Copyright (c) 2015 Ben Emdon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController
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
    
    
    var plays = [Int: Int]()
    var done = false
    var aiDeciding = false
    
    
    @IBAction func UIButtonClicked(sender:UIButton)
    {
        userMessage.hidden=true
        if plays[sender.tag]==nil && !aiDeciding && !done
        {
            setImageToSpot(sender.tag, player:1)
        }
        
        checkForWin()
        aiTurn()
    }
    
    
    
    func setImageToSpot(spot:Int, player:Int)
    {
        var playerMark = player == 1 ? "x-icon2" : "o-icon2"
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
        
    }
    
    
    func checkForWin()
    {
        var whoWon = ["I":0,"you":1]
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
                userMessage.text = "Looks like \(key) won!"
                userMessage.hidden = false
                resetButton.hidden = false
                done = true
            }
        }
    }
    
    //ai function
    //requires delay 
    
    func checkTop(#value:Int) -> (location:String, pattern:String)
    {
        return ("top", checkFor(value, inList: [1,2,3]))
    }
    func checkMiddle(#value:Int) -> (location:String, pattern:String)
    {
        return ("middle", checkFor(value, inList: [4,5,6]))
    }
    func checkBottom(#value:Int) -> (location:String, pattern:String)
    {
        return ("bottom", checkFor(value, inList: [7,8,9]))
    }
    func checkLeft(#value:Int) -> (location:String, pattern:String)
    {
        return ("left", checkFor(value, inList: [1,4,7]))
    }
    func checkMiddleDown(#value:Int) -> (location:String, pattern:String)
    {
        return ("middleDown", checkFor(value, inList: [2,5,8]))
    }
    func checkRight(#value:Int) -> (location:String, pattern:String)
    {
        return ("right", checkFor(value, inList: [3,6,9]))
    }
    func checkDiagLeftRight(#value:Int) -> (location:String, pattern:String)
    {
        return ("diagLeftRight", checkFor(value, inList: [1,5,9]))
    }
    func checkDiagRightLeft(#value:Int) -> (location:String, pattern:String)
    {
        return ("diagRightLeft", checkFor(value, inList: [7,5,3]))
    }
    
    
    
    
    func checkFor(value:Int, inList:[Int]) -> String
    {
        var conclusion = ""
        for cell in inList
        {
            if plays[cell] == value
            {
                conclusion += "1"
            }
            else
            {
                conclusion += "0"
            }
        }
        return conclusion
    }
    
    
    func rowCheck (#value:Int) -> (location:String, pattern:String)?
    {
        var acceptableFinds = ["110", "011", "101"]
        var findFuncs = [checkTop, checkMiddle, checkBottom, checkLeft, checkMiddleDown, checkRight, checkDiagLeftRight, checkDiagRightLeft]
        for algorithm in findFuncs
        {
            var algorithmResults = algorithm(value:value)
            if (find(acceptableFinds,algorithmResults.pattern) != nil)
            {
                return algorithmResults
            }
        }
        return nil
    }
    
    
    func isOccupied(spot:Int) -> Bool
    {
        return plays[spot] != nil
    }
    
    
    func aiTurn()
    {
        if done
        {
            return
        }
        
        aiDeciding = true
        
        //we (the computer) have two in a row
        if let result = rowCheck(value:0)
        {
            var whereToPlayResult = whereToPlay(result.location, pattern:result.pattern)
            if !isOccupied(whereToPlayResult)
            {
                setImageToSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        
        //we (the player) have two in a row
        if let result = rowCheck(value:1)
        {
            var whereToPlayResult = whereToPlay(result.location, pattern:result.pattern)
            if !isOccupied(whereToPlayResult)
            {
                setImageToSpot(whereToPlayResult, player: 0)
                aiDeciding = false
                checkForWin()
                return
            }
        }
        
        
        //is center available?
        if !isOccupied(5)
        {
            setImageToSpot(5, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        
        func firstAvailable(#isCorner:Bool) -> Int?
        {
            var spots = isCorner ? [1, 3, 7, 9] : [2, 4, 6, 8]
            for spot in spots
            {
                if !isOccupied(spot)
                {
                    return spot
                }
            }
            return nil
        }
        
        //is a corner available?
        if let cornerAvailable = firstAvailable(isCorner: true)
        {
            setImageToSpot(cornerAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        //is a side available?
        if let sideAvailable = firstAvailable(isCorner: false)
        {
            setImageToSpot(sideAvailable, player: 0)
            aiDeciding = false
            checkForWin()
            return
        }
        
        userMessage.hidden = false
        userMessage.text = "It's a tie!"
        
        resetButton.hidden =  false
        
        
        aiDeciding = false
        
    }
    
    func whereToPlay(location:String, pattern:String) ->Int
    {
        var leftPattern = "011"
        var rightPattern = "110"
        var middlePattern = "101"
        
        switch location
        {
        case "top":
            if pattern == leftPattern
            {
                return 1
            }
            else if pattern == middlePattern
            {
                return 2
            }
            else
            {
                return 3
            }
        case "middle":
            if pattern == leftPattern
            {
                return 4
            }
            else if pattern == middlePattern
            {
                return 5
            }
            else
            {
                return 6
            }
        case "bottom":
            if pattern == leftPattern
            {
                return 7
            }
            else if pattern == middlePattern
            {
                return 8
            }
            else
            {
                return 9
            }
        case "left":
            if pattern == leftPattern
            {
                return 1
            }
            else if pattern == middlePattern
            {
                return 4
            }
            else
            {
                return 7
            }
        case "middleDown":
            if pattern == leftPattern
            {
                return 2
            }
            else if pattern == middlePattern
            {
                return 5
            }
            else
            {
                return 8
            }
        case "right":
            if pattern == leftPattern
            {
                return 3
            }
            else if pattern == middlePattern
            {
                return 6
            }
            else
            {
                return 9
            }
        case "diagLeftRight":
            if pattern == leftPattern
            {
                return 1
            }
            else if pattern == middlePattern
            {
                return 5
            }
            else
            {
                return 9
            }
        case "diagRightLeft":
            if pattern == leftPattern
            {
                return 3
            }
            else if pattern == middlePattern
            {
                return 5
            }
            else
            {
                return 7
            }
        default:
            return 4
        }
    }
    //end class
}








