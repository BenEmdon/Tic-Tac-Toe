//
//  File.swift
//  Tic Tac To
//
//  Created by Benjamin Emdon on 2015-06-02.
//  Copyright (c) 2015 Ben Emdon. All rights reserved.
//

import UIKit

class FollowDevView: UIViewController
{
    @IBAction func followButtonDidPress(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string:"https://twitter.com/Ben_Emdon")!)
            self.dismissViewControllerAnimated(true, completion: nil)
    } 
}