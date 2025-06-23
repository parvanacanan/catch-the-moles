//
//  ViewController.swift
//  catchMoles
//
//  Created by parvana on 22.06.25.
//

import UIKit

class ViewController: UIViewController {
     @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var mole1: UIImageView!
    @IBOutlet weak var mole2: UIImageView!
    @IBOutlet weak var mole3: UIImageView!
    @IBOutlet weak var mole4: UIImageView!
    @IBOutlet weak var mole5: UIImageView!
    @IBOutlet weak var mole6: UIImageView!
    @IBOutlet weak var mole7: UIImageView!
    @IBOutlet weak var mole8: UIImageView!
    @IBOutlet weak var mole9: UIImageView!
    
    
    var score = 0
    var timer = Timer()
    var counter = 10
    var moleArray = [UIImageView] ()
    var hideTimer = Timer()
    var highscore = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = UIImage(named: "background")
            backgroundImage.contentMode = .scaleAspectFill
            backgroundImage.clipsToBounds = true
            view.insertSubview(backgroundImage, at: 0)
                
        
        
        
// highscore checkk
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        if  storedHighscore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        if let newScore = storedHighscore as? Int {
            highscore = newScore
            highscoreLabel.text = "Highscore : \(highscore)"
        }
         
        mole1.isUserInteractionEnabled = true
        mole2.isUserInteractionEnabled = true
        mole3.isUserInteractionEnabled = true
        mole4.isUserInteractionEnabled = true
        mole5.isUserInteractionEnabled = true
        mole6.isUserInteractionEnabled = true
        mole7.isUserInteractionEnabled = true
        mole8.isUserInteractionEnabled = true
        mole9.isUserInteractionEnabled = true
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(change))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(change))
        mole1.addGestureRecognizer(gestureRecognizer1)
        mole2.addGestureRecognizer(gestureRecognizer2)
        mole3.addGestureRecognizer(gestureRecognizer3)
        mole4.addGestureRecognizer(gestureRecognizer4)
        mole5.addGestureRecognizer(gestureRecognizer5)
        mole6.addGestureRecognizer(gestureRecognizer6)
        mole7.addGestureRecognizer(gestureRecognizer7)
        mole8.addGestureRecognizer(gestureRecognizer8)
        mole9.addGestureRecognizer(gestureRecognizer9)
        moleArray = [ mole1 , mole2 , mole3 , mole4 , mole5 , mole6 , mole7 , mole8 , mole9 ]
        
        
        // timers
        timerLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(countdown), userInfo: nil  , repeats: true)
            
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hiddenMole), userInfo: nil, repeats: true)
        hiddenMole()
         }
   @objc  func hiddenMole() {
        for mole in moleArray {
            mole.isHidden = true
        }
      let random = Int(  arc4random_uniform(UInt32(moleArray.count - 1)) )
        moleArray[random].isHidden = false
    }
     
    @objc func change() {
        
  score += 1
        scoreLabel.text = "Score: \(score)"
    }
    @objc func countdown() {
        counter -= 1
        timerLabel.text = String(counter)
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            for mole in moleArray {
                mole.isHidden = true
            }
            //highscore
            if self.score > self.highscore {
                self.highscore = self.score
                highscoreLabel.text = " Highscore \(self.highscore)"
                UserDefaults.standard.set(self.highscore , forKey: "highscore")
                
    
            }
            
            
            
            //Alert
            let alert = UIAlertController(title: "Times up ", message: "Replay ?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAcrion) in
                //replay func
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timerLabel.text = String(self.counter)
                self.timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(self.countdown), userInfo: nil  , repeats: true)
                    
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hiddenMole), userInfo: nil, repeats: true)
                
            }
            alert.addAction(okButton)
            alert.addAction(replay)
            self.present(alert , animated: true, completion: nil )
        }
        
    }
    
}
