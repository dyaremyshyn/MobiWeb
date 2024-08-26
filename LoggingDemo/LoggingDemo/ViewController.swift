//
//  ViewController.swift
//  LoggingDemo
//
//  Created by Dmytro Yaremyshyn on 25/08/2024.
//

import UIKit
import LoggingSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        LoggingService.logString("teste") { result in
            switch result {
            case .success():
                print("Yeahhh")
            case .failure(let error):
                print("Boooo! \n\(error.localizedDescription)")
            }
        }
    }
}
