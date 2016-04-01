//
//  GameViewController.swift
//  Color IQ
//
//  Created by Parth Pendurkar on 2/7/16.
//  Copyright © 2016 App Gurus. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameMode: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    var colorButtonLeft = true
    var doubleCase = false
    var game = ""
    var score = 0
    var timeLeft = 60
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    //setting color constants
    let colorNames:[String] = ["Red", "Yellow", "Green", "Blue", "Purple"]
    let colorRGB: [UIColor] = [UIColor(red: 0.945, green: 0.271, blue: 0.239, alpha: 1.00), UIColor(red: 0.996, green: 0.914, blue: 0.306, alpha: 1.00), UIColor(red: 0.314, green: 0.682, blue: 0.333, alpha: 1.00), UIColor(red: 0.169, green: 0.596, blue: 0.941, alpha: 1.00), UIColor(red: 0.608, green: 0.184, blue: 0.682, alpha: 1.00)]
    
    @IBAction func button1Pressed(sender: UIButton)
    {
        if (colorButtonLeft)
        {
            changeScore("color")
        }
        else
        {
            changeScore("text")
        }
    }
    
    @IBAction func button2Pressed(sender: UIButton)
    {
        if (colorButtonLeft)
        {
            changeScore("text")
        }
        else
        {
            changeScore("color")
        }
    }
    
    func changeScore(gameMode: String)
    {
        if (game == gameMode || doubleCase)
        {
            print("right")
            score++
        }
        else
        {
            print("wrong")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: "update", userInfo: nil, repeats: true)
        
        let timer1 = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "countdown", userInfo: nil, repeats: true)
    }
    
    func countdown()
    {
        timeLeft--
        timeLabel.text = "\(timeLeft)"
    }
    
    func update()
    {
        let random1 = Int(arc4random_uniform(5))
        let random2 = Int(arc4random_uniform(5))
        let random3 = Int(arc4random_uniform(2))
        let random4 = Int(arc4random_uniform(2))
        
        if (random1 == random2)
        {
            doubleCase = true
        }
        else
        {
            doubleCase = false
        }
        
        let text1 = colorNames[random1]
        let rgb1 = colorRGB[random2]
        let text2 = colorNames[random2]
        let rgb2 = colorRGB[random1]
        wordLabel.text = text1
        wordLabel.textColor = rgb1
        
        if (random3 == 0)
        {
            colorButtonLeft = true
        }
        else
        {
            colorButtonLeft = false
        }
        
        if (random4 == 0)
        {
            game = "text"
        }
        else
        {
            game = "color"
        }
        
        gameMode.text = game
        
        if (colorButtonLeft)
        {
            button1.setTitle(text1, forState: UIControlState.Normal)
            button1.setTitleColor(rgb2, forState: UIControlState.Normal)
            button2.setTitle(text2, forState: UIControlState.Normal)
            button2.setTitleColor(rgb1, forState: UIControlState.Normal)
            colorButtonLeft = false
        }
        else
        {
            button1.setTitle(text2, forState: UIControlState.Normal)
            button1.setTitleColor(rgb1, forState: UIControlState.Normal)
            button2.setTitle(text1, forState: UIControlState.Normal)
            button2.setTitleColor(rgb2, forState: UIControlState.Normal)
            colorButtonLeft = true
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
