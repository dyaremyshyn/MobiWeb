//
//  LoggerViewModel.swift
//  LoggingDemo
//
//  Created by Dmytro Yaremyshyn on 26/08/2024.
//

import Foundation
import Combine

class LoggerViewModel: ObservableObject {
    @Published var successMessage: String? = nil
    @Published var errorMessage: String? = nil
    private var cancellables = Set<AnyCancellable>()
    
    private let loggerService: LoggerService

    init(loggerService: LoggerService) {
        self.loggerService = loggerService
    }
    
    public var title: String {
        LoggerPresenter.viewTitle
    }

    public func logString(string: String) {
        self.loggerService.logString(string: string) { [weak self] result in
            switch result {
            case .success():
                self?.successMessage = LoggerPresenter.successResultMessage
            case .failure(let error):
                self?.errorMessage = LoggerPresenter.errorResultMessage + error.localizedDescription
            }
        }
    }
}
