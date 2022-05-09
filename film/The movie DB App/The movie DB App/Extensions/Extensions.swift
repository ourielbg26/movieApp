//
//  Extentions.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}

extension UILabel {
    func halfTextColorChange(fullText: String ,changeText: String, color: UIColor) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = attribute
    }
}

extension UIActivityIndicatorView {
    func setup(view: UIView) {
        self.center = view.center
        self.hidesWhenStopped = true
        self.style = UIActivityIndicatorView.Style.large
        self.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(self)
    }
}
