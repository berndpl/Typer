//
//  ViewController.swift
//  Typer
//
//  Created by Bernd Plontsch on 16.05.20.
//  Copyright © 2020 Bernd Plontsch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {
    
    var wordBuffer:String = ""
    
    @IBOutlet weak var textField: UITextField!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // MARK: - Model
    
    func didTypeCharacter(character:String) {
        wordBuffer.append(character)
    }
    
    func didPressReturn() {
        speak(utterance: wordBuffer)
        wordBuffer = ""
    }
    
    func speak(utterance:String) {
       let utterance = AVSpeechUtterance(string: utterance)
       utterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
       utterance.rate = 0.4
       let synthesizer = AVSpeechSynthesizer()
       synthesizer.speak(utterance)
    }
    
    // MARK: - TextField Delegates
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        didTypeCharacter(character: string)
        textField.text = string
        speak(utterance: string)
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didPressReturn()
        return false
    }
    
    // MARK: - Setup
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextStyle()
        removeTextAssistantBar()
        textField.becomeFirstResponder()
    }

    func configureTextStyle() {
        let fontSize:CGFloat = 400
        let systemFont = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            textField.font = UIFont(descriptor: descriptor, size: fontSize)
        }
        
        UITextField.appearance().tintColor = .clear
    }
    
    func removeTextAssistantBar() {
        let item:UITextInputAssistantItem = textField.inputAssistantItem
        item.leadingBarButtonGroups = []
        item.trailingBarButtonGroups = []
        textField.autocorrectionType = .no
    }

}

