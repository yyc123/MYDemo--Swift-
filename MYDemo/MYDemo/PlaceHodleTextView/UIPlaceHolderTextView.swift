//
//  UIPlaceHolderTextView.swift
//  MYDemo
//
//  Created by 德基 on 2017/7/26.
//  Copyright © 2017年 yyc. All rights reserved.
//

import UIKit

class UIPlaceHolderTextView: UITextView {

    private let view_TAG = -999
    var placeholder: String?
    var placeholderColor = UIColor.lightGray
    lazy var placeHolderLabel: UILabel! = {
        let  label = UILabel(frame: CGRect(x: 8, y: 8, width: self.bounds.size.width-16, height: 0))
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.backgroundColor = UIColor.clear
        label.textColor = self.placeholderColor
        label.alpha = 0
        label.tag = self.view_TAG
        return label
    }()
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
     convenience init(frame: CGRect) {
        self.init(frame: frame, textContainer: nil)
        setup()

    }
    override func awakeFromNib() {
        setup()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup() {
        placeholder = ""
        placeholderColor = UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged(notification:)), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    @objc private func textChanged(notification: Notification) {
    
        if placeholder?.characters.count == 0 {
            return
        }
        if self.text.characters.count == 0 {
            viewWithTag(view_TAG)?.alpha = 1
        }else{
            viewWithTag(view_TAG)?.alpha = 0
        }
        
    }
    
    override func draw(_ rect: CGRect) {
    
        if (placeholder! as NSString).length > 0 {
            addSubview(placeHolderLabel)

            if self.font != nil {
                placeHolderLabel.font = self.font

            }else{
                placeHolderLabel.font = UIFont.systemFont(ofSize: 12)

            }
            placeHolderLabel.text = self.placeholder
            placeHolderLabel.sizeToFit()
            sendSubview(toBack: placeHolderLabel)
        }
        if (text as NSString).length == 0 && (placeholder! as NSString).length > 0 {
           viewWithTag(view_TAG)?.alpha = 1
        }
        super.draw(rect)
        
    }
}
