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
    var result : Float = 0
    var num1 : Float = 0
    var num2 : Float = 0
    var currentMode : modes = .notSet
    var labelString : String = ""
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
        guard let num: Float = Float(labelString) else {
            updateDisplayLabel(text: "error")
            return
        }
        num1 = num
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        currentMode = .notSet
        result = 0
        num1 = 0
        num2  = 0
        labelString = ""
        updateDisplayLabel(text: "0")
    }
    
    private func reset(){
        currentMode = .notSet
        result = 0
        num1 = 0
        num2  = 0
        labelString = ""
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        guard let num: Float = Float(labelString) else {
            updateDisplayLabel(text: "error")
            reset()
            return
        }
        num2  = num
        calculateBtnPressed = true
        switch currentMode {
        case .add:
            let result : String = String(num1 + num2)
            updateDisplayLabel(text: result)
            labelString = result
        case .minus:
            let result : String = String(num1 - num2)
            updateDisplayLabel(text: result)
            labelString = result
        case .division:
            if (Int(num2) == 0){
                updateDisplayLabel(text: "error")
                reset()
                break
            } else{
                let result : String = String(num1 / num2)
                updateDisplayLabel(text: result)
                labelString = result
            }
        case .multiply:
            let result : String = String(num1*num2)
            updateDisplayLabel(text: result)
            labelString = result
        default:
            return
        }
        currentMode = .notSet
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
            return
        }
        
        if (ceilf(result) == result){
            displayLabel.text = String(Int(result))
        } else {
            displayLabel.text = text
        }
    }
    
}



