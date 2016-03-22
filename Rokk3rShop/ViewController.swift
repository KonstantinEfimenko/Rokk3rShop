//
//  ViewController.swift
//  Rokk3rShop
//
//  Created by Konstantin Efimenko on 3/15/16.
//  Copyright © 2016 Kostiantyn Iefymenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        searchButton.enabled = newText.length > 0
        return true
    }
    
    
    @IBAction func onSearchButtonTapped(sender: AnyObject) {
        
        performSegueWithIdentifier("result", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        if vc.isKindOfClass(ResultViewController){
            (vc as! ResultViewController).searchString = textField.text!
        }
    }
}

