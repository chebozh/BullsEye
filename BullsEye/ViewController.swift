//
//  ViewController.swift
//  BullsEye
//
//  Created by Christian Bozhinov on 11/4/17.
//  
//

import UIKit

class ViewController: UIViewController {
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var roundCount = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var labelTargetValue: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var roundCountLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value)
        startNewRound()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func showAlert() {
        let difference =  abs(targetValue - currentValue)
        var points = 100 - difference
        let title: String
        
        if difference == 0 {
            title = "Perfect! You get a bonus of 100 points!"
            points += 100
        } else if difference == 1{
            title = "So close! You get a bonus of 50 points"
            points += 50
        }else if difference < 5 {
            title = "Almost had it!"
        } else if difference < 10{
            title = "Pretty good!"
        } else {
            title = "You can do better than that!"
        }
        
        let message = "\(currentValue). You scored \(points) points"
        score += points
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
                self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startOver() {
        roundCount = 0
        score = 0
        startNewRound()
    }
    
    func startNewRound() {
        roundCount += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        labelTargetValue.text = String(targetValue)
        userScoreLabel.text = String(score)
        roundCountLabel.text = String(roundCount)
    }

}

