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

    @IBOutlet weak var colorImageView: SpringImageView!
    
    @IBOutlet weak var iqImageView: SpringImageView!
    
    @IBOutlet weak var currentRankPromptLabel: SpringLabel!
    
    @IBOutlet weak var currentRankLabel: SpringLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        iqImageView.hidden = true
        currentRankPromptLabel.hidden = true
        currentRankLabel.hidden = true
        
        colorImageView.image = UIImage(named: "colorpng")!
        colorImageView.contentMode = .ScaleAspectFit
        iqImageView.image = UIImage(named: "iqpng")!
        iqImageView.contentMode = .ScaleAspectFit
        currentRankPromptLabel.font = UIFont(name: "Avenir-Next", size: 12)
        currentRankPromptLabel.text = "Current Rank:"
        currentRankLabel.text = "[test]"
        
        colorImageView.animation = Spring.AnimationPreset.FadeInLeft.rawValue
        colorImageView.duration = 1.0
        iqImageView.animation = Spring.AnimationPreset.FadeInRight.rawValue
        iqImageView.duration = 1.0
        
        currentRankPromptLabel.animation = Spring.AnimationPreset.FadeInLeft.rawValue
        currentRankPromptLabel.duration = 1.0
        currentRankLabel.animation = Spring.AnimationPreset.FadeInRight.rawValue
        currentRankLabel.duration = 1.0
        currentRankLabel.text = Utilities.getCurrentRank()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        colorImageView.animateNext {
            self.iqImageView.hidden = false
            self.iqImageView.animateNext {
                self.currentRankPromptLabel.hidden = false
                self.currentRankPromptLabel.animateNext {
                    self.currentRankLabel.hidden = false
                    self.currentRankLabel.animate()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

