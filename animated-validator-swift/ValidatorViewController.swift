//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBOutlet weak var submitButtonConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.enabled = false
        
        self.emailTextField.delegate = self
        self.emailConfirmationTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passwordTextField.delegate = self
        self.passwordConfirmTextField.delegate = self
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        isValidText(textField)
    }
    
    //This function will be a switch statement to check all cases for acceptabled inputs
    func isValidText(textField: UITextField) {
        
        let goodText = textField.text!.characters.count > 0
        let goodEmail = self.emailTextField.text!.containsString("@") && self.emailTextField.text!.containsString(".")
        let goodEmailConfirmation = self.emailConfirmationTextField.text == self.emailTextField.text && self.emailConfirmationTextField.text!.characters.count > 0
        let goodPhone = self.phoneTextField.text!.characters.count >= 7
        let goodPassword = self.passwordTextField.text?.characters.count >= 6
        let goodConfirmPassword = self.passwordConfirmTextField.text == self.passwordTextField.text && self.passwordConfirmTextField.text?.characters.count > 0
        
        switch textField {
            
        case emailTextField:
            if goodEmail && goodText {
                self.emailTextField.backgroundColor = UIColor.whiteColor()
            } else {
                pulseTextField(emailTextField)
            }
            
        case emailConfirmationTextField :
            if goodEmailConfirmation {
                
                emailConfirmationTextField.backgroundColor = UIColor.clearColor()
            } else {
                
                pulseTextField(emailConfirmationTextField)
            }
            
        case phoneTextField :
            if goodPhone {
                self.phoneTextField.backgroundColor = UIColor.clearColor()
            } else {
                pulseTextField(self.phoneTextField)
            }
        case passwordTextField :
            if goodPassword {
                phoneTextField.backgroundColor = UIColor.clearColor()
            } else {
                pulseTextField(passwordTextField)
            }
            
        case passwordConfirmTextField :
            if goodConfirmPassword && goodPassword {
                passwordConfirmTextField.backgroundColor = UIColor.clearColor()
            } else {
                pulseTextField(passwordConfirmTextField)
            }
        default : break
        }
        
        if goodText && goodEmail && goodEmailConfirmation && goodPhone && goodPassword && goodConfirmPassword {
            moveButton()
            self.submitButton.enabled = true
        }
    }


    //Will use this function to call on each textField when certain criteria are met
    func pulseTextField(textField: UITextField) {
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: [.Repeat, .Autoreverse], animations: {
            UIView.setAnimationRepeatCount(3.0)
            textField.transform = CGAffineTransformMakeScale(0.98, 0.98)
            textField.backgroundColor = UIColor.redColor()
            textField.alpha = 0.5
            self.view.layoutIfNeeded()
            
        }) { (true) in
            textField.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }
    }
    
    //When all criteria for accepted textField inputs are met, this method will be called.
    func moveButton() {
        UIView.animateWithDuration(1) {
            self.submitButtonConstraint.constant = -45
            self.view.layoutIfNeeded()
       }
    }
}