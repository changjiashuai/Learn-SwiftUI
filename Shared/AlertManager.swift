//
//  AlertManager.swift
//  Learn-SwiftUI
//
//  Created by CJS on 2021/8/15.
//

import UIKit

class AlertManager {
    
    static let shared = AlertManager()

    func show(title: String, message: String,
              defaultTitle: String? = nil, defaultAction: ((UIAlertAction) -> Void)? = nil,
              cancelTitle: String? = nil, cancelAction: ((UIAlertAction) -> Void)? = nil,
              destructiveTitle: String? = nil, destructiveAction: ((UIAlertAction) -> Void)? = nil) {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
           let container = window.rootViewController {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let defaultAlertAction = UIAlertAction(title: defaultTitle, style: .default, handler: defaultAction)
            let cancelAlertAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelAction)
            let destructiveAlertAction = UIAlertAction(title: destructiveTitle, style: .destructive, handler: destructiveAction)
            alertController.addAction(defaultAlertAction)
            alertController.addAction(cancelAlertAction)
            alertController.addAction(destructiveAlertAction)
            container.present(alertController, animated: true, completion: nil)
        }
    }
}
