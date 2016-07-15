//
//  ViewController.swift
//  Zurich
//
//  Created by Samuel B Heather on 09/05/2016.
//  Copyright © 2016 Freedom Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var time:UILabel!
    @IBOutlet var background:UIImageView!
    
    var possibleBackgrounds: [UIImage] = [
        UIImage(named: "campingNight.jpg")!,
        UIImage(named: "campingNight2.jpg")!
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        background.image = possibleBackgrounds.randomItem()
        
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
        
        update()
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willEnterForeground), name: UIApplicationWillEnterForegroundNotification, object: nil)
    }
    
    func willEnterForeground() {
        background.image = possibleBackgrounds.randomItem()
    }
    
    func update() {
        let target = NSDate(timeIntervalSince1970: 1470857880)
        let current = NSDate()
        var remaining = target.timeIntervalSinceDate(current)
        if remaining < 0 {
            updateLabel("0 days\n00:00:00")
            return
        }
        print(remaining)
        
        let days:Int = Int(remaining)/Int(86400)
        let daysString = String(days)
        
        remaining = remaining - Double(days*86400)
        
        let interval:NSDate = NSDate(timeIntervalSince1970: remaining)
        let formatter:NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = NSTimeZone(name: "UTC")
        
        updateLabel(daysString+" days\n"+formatter.stringFromDate(interval))
        
    }
    
    func updateLabel(s:String) {
        time.text = s
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}