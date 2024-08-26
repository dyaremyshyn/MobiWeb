//
//  LoggerComposer.swift
//  LoggingDemo
//
//  Created by Dmytro Yaremyshyn on 26/08/2024.
//

import Foundation

public final class LoggerComposer {
    
    private init() {}
    
    public static func loggerComposedWith(loggerService: LoggerService) -> LoggerViewController {
        let viewModel = LoggerViewModel(loggerService: loggerService)
        let viewController = LoggerViewController.makeWith(viewModel: viewModel)
        return viewController
    }
}

extension LoggerViewController {
    static func makeWith(viewModel: LoggerViewModel) -> LoggerViewController {
        let viewController = LoggerViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
