//
//  ViewController.swift
//  myfirstiosapp
//
//  Created by Viet Pham on 5/11/20.
//  Copyright © 2020 Viet Pham. All rights reserved.
//

import UIKit
import Foundation

enum modes {
    case notSet
    case add
    case minus
    case multiply
    case division
}

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    var num1 : Float? = nil
    var currentMode : modes = .notSet
    var labelString : String = ""
    var currentResult: Float = 0
    var calculateBtnPressed: Bool = false
    var modeBtnPressedLast: Bool = false
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let digit: String = sender.titleLabel?.text else {
            return
        }
        appendNumber(digit: digit)
    }
    
    @IBAction func modeChange(_ sender: UIButton) {
        
        guard let mode: String = sender.titleLabel?.text else {
            return
        }
        
        modeBtnPressedLast = true
        if (labelString != ""){
            if (num1 == nil){
                num1 = Float(labelString)!
                labelString = ""
            } else {
                num1 = doMath(num1: num1!, num2: Float(labelString)!)
            }
        }
        
        switch mode{
        case "/":
            currentMode = .division
        case "x":
            currentMode = .multiply
        case "+":
            currentMode = .add
        default:
            currentMode = .minus
        }
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        currentMode = .notSet
        num1 = nil
        labelString = ""
        updateDisplayLabel(text: "0")
    }
    
    private func reset(){
        currentMode = .notSet
        currentResult = 0
        num1 = nil
        labelString = ""
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        if (currentMode != .notSet && labelString != ""){
            num1 = doMath(num1: num1!, num2: Float(labelString)!)
            currentMode = .notSet
        }
    }
    
    private func doMath(num1: Float, num2: Float) -> Float{
        var result : String = ""
        calculateBtnPressed = true
        switch currentMode {
        case .add:
            result = String(num1 + num2)
            currentResult = num1 + num2
        case .minus:
            result = String(num1 - num2)
            currentResult = num1 - num2
        case .division:
            if (num2 == Float(0)){
                updateDisplayLabel(text: "error")
                reset()
                return 0
            } else{
                result = String(num1 / num2)
                currentResult = num1 / num2
            }
        case .multiply:
            result = String(num1*num2)
            currentResult = num1*num2
        default:
            currentResult = 0
            return 0
        }
        updateDisplayLabel(text: result)
        labelString = ""
        return currentResult
    }
    
    private func appendNumber(digit: String){
        if (modeBtnPressedLast || calculateBtnPressed){
            labelString = ""
        }
        
        calculateBtnPressed = false
        modeBtnPressedLast = false
        
        labelString = labelString.appending(digit)
        updateDisplayLabel(text: labelString)
    }
    
    private func updateDisplayLabel(text: String){
        guard let result : Float = Float(text) else {
            displayLabel.text = text
            return
        }
        
        if (ceilf(result) == result){
            displayLabel.text = String(Int(result))
        } else {
            displayLabel.text = text
        }
    }
    
}



