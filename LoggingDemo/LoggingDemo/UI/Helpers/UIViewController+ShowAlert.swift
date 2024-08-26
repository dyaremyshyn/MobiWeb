//
//  UIViewController+ShowAlert.swift
//  LoggingDemo
//
//  Created by Dmytro Yaremyshyn on 26/08/2024.
//

import UIKit

extension UIViewController {

    func showErrorDialog(title: String?, message: String?, cancelTitle: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
}
