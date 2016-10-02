//
//  GameViewController.swift
//  Color IQ
//
//  Created by Parth Pendurkar on 2/7/16.
//  Copyright © 2016 App Gurus. All rights reserved.
//

import UIKit
import Spring
import Material

class GameViewController: UIViewController {
    
    //setting outlets, constants and variables
    @IBOutlet weak var gameMode: SpringLabel!
    @IBOutlet weak var wordLabel: SpringLabel!
    var colorButtonLeft = true
    var doubleCase = false
    var game = ""
    var score = 0
    var timeLeft = 10
    var degreesToDecrease = 0
    var gameOn = false
    @IBOutlet weak var button1: SpringButton!
    @IBOutlet weak var button2: SpringButton!
    @IBOutlet weak var timeLabel: SpringLabel!
    @IBOutlet weak var circularTimeBar: KDCircularProgress!
    
    /*
    @IBOutlet weak var gameOverOverlay: SpringView!
    @IBOutlet weak var overlayScoreLabel: UILabel!
    @IBOutlet weak var overlayHighScoreLabel: UILabel!
    @IBOutlet weak var overlayRankLabel: UILabel!
    */
    
    //setting color constants
    let colorNames:[String] = ["Red", "Yellow", "Green", "Blue", "Purple"]
    let colorRGB: [UIColor] = [UIColor(hex: "#f1453d"),
                               UIColor(hex: "#fee94e"),
                               UIColor(hex: "#50ae55"),
                               UIColor(hex: "#2b98f0"),
                               UIColor(hex: "#9b2fae")]
    let colorDictionary: [String: UIColor] = ["Red" : UIColor(hex: "#f1453d"),
                                              "Yellow" : UIColor(hex: "#fee94e"),
                                              "Green" : UIColor(hex: "#50ae55"),
                                              "Blue" : UIColor(hex: "#2b98f0"),
                                              "Purple" : UIColor(hex: "#9b2fae")]
    
    //setting timer constants
    var fiveSecondTimer: NSTimer!
    var overallGameTimer: NSTimer!
    var countdownTimer: NSTimer!
    
    @IBAction func button1Pressed(sender: AnyObject)
    {
        print("button1pressed")
        button1.animation = Spring.AnimationPreset.ZoomIn.rawValue
        button1.animate()
        colorButtonLeft ? changeScore("color") : changeScore("text")
    }
    
    @IBAction func button2Pressed(sender: AnyObject)
    {
        print("button2 pressed")
        button2.animation = Spring.AnimationPreset.ZoomIn.rawValue
        button2.animate()
        colorButtonLeft ? changeScore("text") : changeScore("color")
    }
    
    func changeScore(gameMode: String)
    {
        //if the current game is the same as the game mode expressed by the button that is pressed, the score is increased by 1; this is also true if the text and font color are the same - a "double case"
        if (game == gameMode || doubleCase)
        {
            if (!gameOn)
            {
                gameOn = true
                startGame()
            }
            print("right")
            score += 1
            if (fiveSecondTimer != nil)
            {
                fiveSecondTimer.invalidate()
            }
            update()
            fiveSecondTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(GameViewController.timeUp), userInfo: nil, repeats: true)
        }
            
        else
        {
            if (gameOn)
            {
                print("wrong")
                score -= 1
            }
            self.gameMode.animation = Spring.AnimationPreset.Shake.rawValue
            self.gameMode.animate()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        wordLabel.hidden = false
        gameMode.hidden = false
        button1.hidden = false
        button2.hidden = false
        gameOn = false
        update()
        
        button1.userInteractionEnabled = true;
        button2.userInteractionEnabled = true;
        
        degreesToDecrease = 360 / timeLeft
        //degreesToDecrease += degreesToDecrease / (timeLeft - 1) //hacky way to make full circle complete
        timeLabel.hidden = true
        
        wordLabel.backgroundColor = UIColor.clearColor()
        wordLabel.adjustsFontSizeToFitWidth = true
        wordLabel.font = wordLabel.font.fontWithSize(64)
        wordLabel.textAlignment = .Center
        wordLabel.sizeToFit()
        
        gameMode.backgroundColor = UIColor.clearColor()
        gameMode.adjustsFontSizeToFitWidth = true
        gameMode.font = wordLabel.font.fontWithSize(32)
        gameMode.textColor = UIColor.lightGrayColor()
        gameMode.textAlignment = .Center
        gameMode.sizeToFit()
        
        button1.layer.cornerRadius = button1.frame.width / 2
        button2.layer.cornerRadius = button1.frame.width / 2
        
        circularTimeBar.startAngle = 90
        circularTimeBar.trackColor = UIColor.clearColor()
        circularTimeBar.progressThickness = 0.2
        circularTimeBar.glowMode = KDCircularProgressGlowMode.NoGlow
        circularTimeBar.setColors(UIColor.lightGrayColor())
        //make circular time bar appear in beginning of game
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        print("tap recognized")
        startGame()
        return false
    }
    
    func startGame()
    {
        countdown()
        
        overallGameTimer = NSTimer.scheduledTimerWithTimeInterval(Double(timeLeft + 1), target: self, selector: #selector(GameViewController.gameOver), userInfo: nil, repeats: false)
        
        countdownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(GameViewController.countdown), userInfo: nil, repeats: true)
    }
    
    //changes on a set interval, also changing the timer label
    func countdown()
    {
        let currentAngle = circularTimeBar.angle
        circularTimeBar.animateFromAngle(currentAngle, toAngle: currentAngle - Double(degreesToDecrease), duration: 1.0, completion: nil)
        timeLeft -= 1
        timeLabel.text = "\(timeLeft)"
    }
    
    func timeUp()
    {
        /*
        gameMode.animation = Spring.AnimationPreset.Shake.rawValue
        gameMode.animate()
        */
        
        //add completion handler below to make wordLabel shake
        wordLabel.animation = Spring.AnimationPreset.Shake.rawValue
        wordLabel.duration = 1.0
        wordLabel.animateToNext {
            self.update()
        }
    }
    
    func update()
    {
        
        //randoms for word text and font color
        let random1 = Int(arc4random_uniform(5))
        let random2 = Int(arc4random_uniform(5))
        
        //random for what side of the screen the color button is on
        let random3 = Int(arc4random_uniform(2))
        
        //random for current game mode - either text or color
        let random4 = Int(arc4random_uniform(2))
        
        //random for entry animation
        let random5 = Int(arc4random_uniform(4))
        
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
        switch random5
        {
        case 0:
            wordLabel.animation = Spring.AnimationPreset.FadeInDown.rawValue
        case 1:
            wordLabel.animation = Spring.AnimationPreset.FadeInRight.rawValue
        case 2:
            wordLabel.animation = Spring.AnimationPreset.FadeInUp.rawValue
        case 3:
            wordLabel.animation = Spring.AnimationPreset.FadeInLeft.rawValue
        default:
            wordLabel.animation = Spring.AnimationPreset.Pop.rawValue
        }
        wordLabel.animate()
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
        
        gameMode.animation = Spring.AnimationPreset.FadeIn.rawValue
        gameMode.animate()
        gameMode.text = game
        
        if (colorButtonLeft)
        {
            button1.backgroundColor = colorDictionary[text1]
            button2.backgroundColor = colorDictionary[text2]
            colorButtonLeft = false
        }
        else
        {
            button1.backgroundColor = colorDictionary[text2]
            button2.backgroundColor = colorDictionary[text1]
            colorButtonLeft = true
        }
    }
    
    //TODO: this method *might* be useless, ask Parth
    func setOptions(element: Springable)
    {
        element.force = 1.0
        element.duration = 0.5
        element.delay = 0.0
        
        element.damping = 0.5
        element.velocity = 0.5
        element.scaleX = 1.0
        element.scaleY = 1.0
        element.x = 0.0
        element.y = 0.0
        element.rotate = 0.0
        
        element.animation = Spring.AnimationPreset.ZoomIn.rawValue
    }
    
    func dismissGameplayScreen(gameOverOverlay: SpringView)
    {
        wordLabel.animation = Spring.AnimationPreset.Fall.rawValue
        wordLabel.duration = 1.0
        gameMode.animation = Spring.AnimationPreset.Fall.rawValue
        gameMode.duration = 1.0
        button1.animation = Spring.AnimationPreset.Fall.rawValue
        button1.duration = 1.0
        button2.animation = Spring.AnimationPreset.Fall.rawValue
        button2.duration = 1.0
        wordLabel.animate()
        gameMode.animate()
        button1.animate()
        button2.animateToNext
            {
            gameOverOverlay.animation = Spring.AnimationPreset.FadeInUp.rawValue
            gameOverOverlay.hidden = false;
            gameOverOverlay.animate()
            self.wordLabel.hidden = true
            self.gameMode.hidden = true
            self.button1.hidden = true
            self.button2.hidden = true
        }
    }
    
    func gameOver()
    {
        gameOn = false
        button1.userInteractionEnabled = false;
        button2.userInteractionEnabled = false;
        
        if (score < 0)
        {
            score = 0
        }
        
        let gameOverOverlay = NSBundle.mainBundle().loadNibNamed("GameOverOverlay", owner: nil, options: nil)[0] as! SpringView
        
        
        //gameOverOverlay.frame = CGRectMake(0, 0, 240, 240)
        gameOverOverlay.frame = CGRectZero
        gameOverOverlay.hidden = true
        view.layout(gameOverOverlay).centerHorizontally().centerVertically().width(240).height(240)
        

        //self.view.addSubview(gameOverOverlay)
        
        let overlayScoreLabel = gameOverOverlay.viewWithTag(1) as! UILabel
        overlayScoreLabel.text = String(score)
        let highScore = Utilities.updateHighScore(score)
        let overlayHighScoreLabel = gameOverOverlay.viewWithTag(2) as! UILabel
        overlayHighScoreLabel.text = String(highScore)
        let overlayRankLabel = gameOverOverlay.viewWithTag(3) as! UILabel
        overlayRankLabel.text = Utilities.getRankString(score)
        
        
        
        Utilities.updateRank(score)
        dismissGameplayScreen(gameOverOverlay)
        overallGameTimer.invalidate()
        fiveSecondTimer.invalidate()
        countdownTimer.invalidate()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(restartGame))
        self.view.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func restartGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gvc = storyboard.instantiateViewControllerWithIdentifier("GameViewController")
        self.presentViewController(gvc, animated: true, completion: nil)
    }
   

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
