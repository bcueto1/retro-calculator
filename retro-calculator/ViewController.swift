//
//  ViewController.swift
//  retro-calculator
//
//  Created by Brian Cueto on 8/13/16.
//  Copyright © 2016 Brian Cueto. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
   
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty

    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func clearPressed(sender: AnyObject) {
        playSound()
        
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
    }
    
    @IBAction func whenDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func whenMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func whenAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func whenSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func whenEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

