//
//  ViewController.swift
//  calculator
//
//  Created by Гриша on 19.01.17.
//  Copyright © 2017 ru.sapgv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func actionResult(sender: AnyObject) {
        
        if let inputString = inputField.text {
        
            let formula = prepareFormula(inputString)
            let expr = prepareExpr(formula)
            
            let formulaRPN = reversePolishNotation(expr).componentsSeparatedByString(" ")
            let result =  evaluate(formulaRPN)
            
            resultLabel.text = String(result)
            
        }
    }
    
    func prepareFormula(inputString: String) -> [String] {
    
        let operation = "+-*/^()"
        var outputString = ""
        
        for char in inputString.characters {
            
            if operation.containsString(String(char)) {
                outputString += " " + String(char) + " "
            }
            else {
                outputString += String(char)
            }
        }
        
        return outputString.componentsSeparatedByString(" ")
    }
    
    func prepareExpr(formula: [String]) -> [Token] {
        
        let expr = InfixExpressionBuilder()
        
        
        for char in formula {
            
            let char = String(char)
            
            if char == " " || char == "" {
                continue
            }
            
            if tokenIsNumeric(char) {
                expr.addOperand(Double(char)!)
            }
                
            else if tokenIsOperation(char) {
                
                switch char {
                case "+":
                    expr.addOperator(.add)

                case "-":
                    
                    if let lastExpr = expr.last() {
                        
                        if lastExpr.isOpenBracket || lastExpr.isClosedBracket || lastExpr.isOperator {
                            expr.addOperator(.unary)
                        }
                        else {
                            expr.addOperator(.subtract)
                        }
                        
                    }
                    else {
                        expr.addOperator(.unary)
                    }

                case "*":
                    expr.addOperator(.multiply)
                case "/":
                    expr.addOperator(.divide)
                case "^":
                    expr.addOperator(.exponent)
                case "(":
                    expr.addOpenBracket()
                case ")":
                    expr.addCloseBracket()
                default:
                    break
                }
                
            }
            
        }

        
        return expr.build()
        
    }

    
//    func prepareExpr(formula: String) -> [Token] {
//    
//        let expr = InfixExpressionBuilder()
//        
//        var prevchar = ""
//        var prevoperation = ""
//        
//        for char in formula.characters {
//            
//            let char = String(char)
//            
//            if char == " " {
//                continue
//            }
//            
//            if tokenIsNumeric(char) || char == "." {
//                prevchar += char
//            }
//            else if tokenIsNumeric(char) {
//                prevchar = char
//            }
//                
//            
//            else if tokenIsOperation(char) {
//                
//                if tokenIsNumeric(prevchar) {
//                    expr.addOperand(Double(prevchar)!)
//                    prevchar = ""
//                    prevoperation = ""
//                }
//                else if tokenIsOperation(prevchar) {
//                    
//                }
//                
//                switch char {
//                case "+":
//                    expr.addOperator(.add)
//                case "-" where !tokenIsOperation(prevoperation) && prevchar != "":
//                    expr.addOperator(.subtract)
//                case "-" where tokenIsOperation(prevoperation) || prevchar == "":
//                    expr.addOperator(.unary)
//                case "*":
//                    expr.addOperator(.multiply)
//                case "/":
//                    expr.addOperator(.divide)
//                case "^":
//                    expr.addOperator(.exponent)
//                case "(":
//                    expr.addOpenBracket()
//                case ")":
//                    expr.addCloseBracket()
//                default:
//                    break
//                }
//                
//                prevoperation = char
//            }
//            
//        }
//        if tokenIsNumeric(prevchar) {
//            expr.addOperand(Double(prevchar)!)
//        }
//        
//        return expr.build()
//        
//    }
    


}

