//
//  ViewController.swift
//  NoSpacesAllowed
//
//  Created by misha birman1 on 2/10/15.
//  Copyright (c) 2015 misha birman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var MyText: UITextField!
    @IBOutlet weak var MyText2: UITextField!
    @IBOutlet weak var MyText3: UITextField!
    @IBOutlet weak var MySwitch: UISwitch!
    
    @IBAction func valueChanged(sender: UISwitch) {
        self.switchOn = sender.on
    }
    
    var numbers: [String] = []
    var switchOn:Bool!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.MyText.delegate = self;
        self.MyText2.delegate = self
        self.MyText3.delegate = self
        
        self.switchOn = MySwitch.on
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        var result = true
        var length = countElements(MyText.text)
        
        if textField == MyText {
            result = length < 5
        }
        
        
        if textField == MyText3{
            if (switchOn == false){
                result = false;
            }
        }
        
        if (textField == MyText2){
            
            //$0.00
            //$0.02
            let disallowedCharacterSet = NSCharacterSet(charactersInString: "1234567890").invertedSet
            let replacementStringIsLegal = string.rangeOfCharacterFromSet(disallowedCharacterSet) == nil
            result = replacementStringIsLegal;
            if (replacementStringIsLegal)
            {
                if (string == "" && numbers.count > 0)
                {
                    numbers.removeLast()
                }
                if (string != "")
                {
                    numbers.append(string)
                }
                
                let c = numbers.count
                
                if (c == 0)
                {
                    MyText2.text = "$0.00"
                }
                if (c == 1)
                {
                    MyText2.text = "$0.0" + numbers[0]
                }
                
                if (c == 2)
                {
                    MyText2.text = "$0." + numbers[0] + numbers[1]
                }
                
                if (c > 2)
                {
                    var t:String = "";
                    t = "$"
                    for i in 0..<numbers.count{
                        if (i == numbers.count - 2)
                        {
                            t = t + "."
                        }
                        println(numbers[i])
                        t = t + numbers[i]
                    }
                    MyText2.text = t;
                }
                
            }
            result = false;
        }
        
        return result
    }
}

