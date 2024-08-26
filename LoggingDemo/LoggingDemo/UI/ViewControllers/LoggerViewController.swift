//
//  LoggerViewController.swift
//  LoggingDemo
//
//  Created by Dmytro Yaremyshyn on 25/08/2024.
//

import UIKit
import Combine

public class LoggerViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = LoggerPresenter.textFieldPlaceholder
        return textField
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(LoggerPresenter.submitButtonTitle, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textField, submitButton, UIView(), resultLabel])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var cancellables = Set<AnyCancellable>()
    var viewModel: LoggerViewModel? {
        didSet { bind() }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func bind() {
        viewModel?.$successMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard let self else { return }
                self.resultLabel.text = message
            }
            .store(in: &cancellables)
        
        viewModel?.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self, let message = errorMessage else { return }
                self.display(errorMessage: message)
            }
            .store(in: &cancellables)
    }

    private func setupView() {
        title = viewModel?.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(verticalStackView)
        
        verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
}

extension LoggerViewController {
    @objc private func submitTapped() {
        resultLabel.text = ""
        guard let text = textField.text, !text.isEmpty else {
            showErrorDialog(
                title: LoggerPresenter.errorDialogTitle,
                message: LoggerPresenter.emptyTextFieldMessage,
                cancelTitle: LoggerPresenter.launchDialogCancel
            )
            return
        }
        viewModel?.logString(string: text)
    }
}

//MARK: Display Error
extension LoggerViewController {
    // Displaying error message in dialog
    public func display(errorMessage: String?) {      
        showErrorDialog(
            title: LoggerPresenter.errorDialogTitle,
            message: errorMessage,
            cancelTitle: LoggerPresenter.launchDialogCancel)       
    }
}
