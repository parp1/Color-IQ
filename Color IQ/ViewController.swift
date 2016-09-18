//
//  ViewController.swift
//  Color IQ
//
//  Created by Parth Pendurkar on 2/7/16.
//  Copyright © 2016 App Gurus. All rights reserved.
//

import UIKit
import Spring

class ViewController: UIViewController {

    @IBOutlet weak var colorIQImageView: SpringImageView!
    
    @IBOutlet weak var currentRankPromptLabel: SpringLabel!
    
    @IBOutlet weak var currentRankLabel: SpringLabel!
    
    @IBOutlet weak var tapToPlayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        colorIQImageView.hidden = true
        currentRankPromptLabel.hidden = true
        currentRankLabel.hidden = true
        tapToPlayLabel.hidden = true
        tapToPlayLabel.font = UIFont(name: "Avenir-Next", size: 12)
        tapToPlayLabel.textAlignment = .Center
        
        colorIQImageView.image = UIImage(named: "coloriqlogowhite")!
        colorIQImageView.contentMode = .ScaleAspectFit
        currentRankPromptLabel.font = UIFont(name: "Avenir-Next", size: 12)
        currentRankPromptLabel.textAlignment = .Center
        currentRankPromptLabel.textColor = UIColor.lightGrayColor()
        currentRankPromptLabel.text = "Current Rank"
        currentRankLabel.font = UIFont(name: "AvenirNext-Bold", size: 36)
        currentRankLabel.textAlignment = .Center
        currentRankLabel.text = "test"
        
        colorIQImageView.animation = Spring.AnimationPreset.SlideDown.rawValue
        colorIQImageView.duration = 1.0
        
        currentRankPromptLabel.animation = Spring.AnimationPreset.SlideUp.rawValue
        currentRankPromptLabel.duration = 1.0
        currentRankLabel.animation = Spring.AnimationPreset.SlideUp.rawValue
        currentRankLabel.duration = 1.0
        currentRankLabel.text = Utilities.getCurrentRank()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        colorIQImageView.hidden = false
        colorIQImageView.animateNext {
            self.currentRankPromptLabel.hidden = false
            self.currentRankPromptLabel.animateNext {
                self.currentRankLabel.hidden = false
                self.currentRankLabel.animateNext {
                    let timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(ViewController.toggleVisible), userInfo: nil, repeats: true)
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.startGame))
                    self.view.addGestureRecognizer(tapGestureRecognizer)
                }
            }
        }
    }
    
    func toggleVisible() {
        tapToPlayLabel.hidden = !tapToPlayLabel.hidden
    }
    
    func startGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gvc = storyboard.instantiateViewControllerWithIdentifier("GameViewController")
        self.presentViewController(gvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

