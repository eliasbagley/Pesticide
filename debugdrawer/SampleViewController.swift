//
//  SampleViewController.swift
//  debugdrawer
//
//  Created by Daniel Gubler on 11/21/14.
//  Copyright (c) 2014 Rocketmade. All rights reserved.
//

class SampleViewController : UIViewController {
    
    let textField : UITextField = UITextField()
    let enterButton : UIButton = UIButton()
    let label : UILabel = UILabel()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override init() {
        super.init()
        self.setupView()
        
        self.enterButton.addTarget(self, action: Selector("enterButtonTouch:"), forControlEvents: .TouchUpInside)
    }
    
    func enterButtonTouch(sender: UIButton!) {
        self.label.text = "Hello, " + self.textField.text
    }
    
    func setupView() {
        self.view.backgroundColor = .blueColor()
        
        self.enterButton.setTitle("Say Hello", forState: .Normal)
        self.enterButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.textField.placeholder = "Your Name"
        
        self.textField.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.enterButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.textField.backgroundColor = .whiteColor()
        self.enterButton.backgroundColor = .whiteColor()
        self.label.backgroundColor = .whiteColor()
        
        self.view.addSubview(self.textField)
        self.view.addSubview(self.enterButton)
        self.view.addSubview(self.label)
        
        self.applyConstraints()
    }
    
    func applyConstraints() {
        
        let bindings = ["textField": self.textField,
                        "button": self.enterButton,
                        "label": self.label]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|-(40)-[textField(40)]-[button(40)]-[label(40)]", options: NSLayoutFormatOptions(0), metrics: nil, views: bindings))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-[textField]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: bindings))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-[button]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: bindings))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(
            "|-[label]-|", options: NSLayoutFormatOptions(0), metrics: nil, views: bindings))
    }
}