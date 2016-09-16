//
//  ViewController.swift
//  Calculator
//
//  Created by 诸葛俊伟 on 5/1/16.
//  Copyright © 2016 Stanford University. All rights reserved.
//

import UIKit

var calculatorCount = 0

class CalculatorViewController: UIViewController, UISplitViewControllerDelegate
{
    @IBOutlet fileprivate weak var display: UILabel!
    
    fileprivate var userIsInTheMiddleOfTypingNumber = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("Loaded up a new Calculator (Count = \(calculatorCount))")
        brain.addUnaryOperation("Red√") { [unowned me = self] in
            me.display.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    
    
    deinit {
        calculatorCount -= 1
        print("Calculator left the heap (Count = \(calculatorCount))")

    }
    
    @IBAction fileprivate func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingNumber {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTypingNumber = true
    }
    
    fileprivate var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTypingNumber {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTypingNumber = false
        }
        userIsInTheMiddleOfTypingNumber = false
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    } 
}

