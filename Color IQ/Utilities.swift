//
//  Utilities.swift
//  Color IQ
//
//  Created by Parth Pendurkar on 7/30/16.
//  Copyright © 2016 App Gurus. All rights reserved.
//

import Foundation

class Utilities {
    
    static let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static let ranks = ["Deficient",
                       "Noob",
                       "Amateur",
                       "Just Average",
                       "Getting There",
                       "Well Read",
                       "Good",
                       "Great",
                       "Professional Grade",
                       "Veteran"]
    
    static func getCurrentRank() -> String {
        var rank = userDefaults.integerForKey("rank")
        
        if (rank == 0) {
            rank = 1
        }
        
        return ranks[rank - 1]
    }
    
    static func getRank(score: Int) -> Int {
        var rank = 1
        
        switch score {
        case 0...5:
            rank = 1
        case 5...10:
            rank = 2
        case 10...15:
            rank = 3
        case 15...20:
            rank = 4
        case 20...25:
            rank = 5
        case 25...35:
            rank = 6
        case 35...45:
            rank = 7
        case 45...60:
            rank = 8
        case 60...100:
            rank = 9
        case _ where score >= 100:
            rank = 10
        default:
            rank = 1
        }
        
        return rank
    }
    
    static func getRankString(score: Int) -> String {
        let rank = getRank(score)
        return ranks[rank]
    }
    
    static func updateRank(score: Int) {
        let previousRank = userDefaults.integerForKey("rank")
        let rank = getRank(score)
        
        if (rank > previousRank) {
            userDefaults.setInteger(rank, forKey: "rank")
        }
    }
    
    static func updateHighScore(score: Int) -> Int {
        var highScore = userDefaults.integerForKey("highScore")
        
        if (score > highScore) {
            userDefaults.setInteger(score, forKey: "highScore")
            highScore = score
        }
        
        return highScore
    }
    
    
}