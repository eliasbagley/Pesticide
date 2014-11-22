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
        
        #if DEBUG
            Pesticide.addCommand("log", block: { (components: Array<String>) in
                if components.count < 1 {
                    return;
                }
                if let times = components[0].toInt() {
                    for count in 0..<times {
                        Pesticide.log("did it \(count)")
                    }
                }
            })
            
            Pesticide.addCommand("stab", block: { (components: Array<String>) in
                if components.count < 1 {
                    return;
                }
                if let times = components[0].toInt() {
                    for count in 0..<times {
                        Pesticide.log("die, die, die")
                    }
                }
            })
            
            Pesticide.addButton("crash", { () in
                assert(false, "SOME CRASH AHHHH!!!!")
            })
            
            Pesticide.addSlider(Float(self.view.alpha),name:"alpha", block: { (value :Float) in
                let currentColor = self.view.backgroundColor
                self.view.alpha = CGFloat(value)
            })
            
            Pesticide.addTextInput("auto layout", block: { (text: String) in
                self.label.text = text
            })
            
            Pesticide.addDropdown("Blue",name: "color", options: ["Black":UIColor.blackColor(),"Blue":UIColor.blueColor(),"Red":UIColor.redColor(),"Green":UIColor.greenColor()], block:{(option:AnyObject) in
                let newColor = option as UIColor
                self.view.backgroundColor = newColor
                })
        #endif
        
        print("sample inited")
    }
    
    func enterButtonTouch(sender: UIButton!) {
        self.label.text = "Hello, " + self.textField.text
        #if DEBUG
            Pesticide.log("INPUT: \(self.textField.text)")
        #endif
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