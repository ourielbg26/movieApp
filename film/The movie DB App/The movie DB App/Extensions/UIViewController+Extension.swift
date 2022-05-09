//
//  UIViewController+Extension.swift
//  The movie DB App
//
//  Created by Itzik Bar-Noy on 22/06/2020.
//  Copyright © 2019 Itzik Bar-Noy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showGenericError() {
        let alert = UIAlertController(title: Constants.ErrorMessage.title, message: Constants.ErrorMessage.description, preferredStyle: .alert)
        let action = UIAlertAction(title: "O.K.", style: .destructive)
        
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
