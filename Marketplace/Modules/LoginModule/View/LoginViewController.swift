//
//  LoginVC.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import Combine
import UIKit
import SnapKit

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel: any LoginViewModel
    private var cancellables = Set<AnyCancellable>()
    private let loginField = UITextField()
    private let passwordField = UITextField()
    private var loginFieldView: TextFieldView
    private var passwordFieldView: TextFieldView
    private let filledButton = FilledButton(title: Constants.title)
    private lazy var isSecureText = true
    private var notificationConstraint: Constraint?
    
    private lazy var marketLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.marketLogoImageName)
        return imageView
    }()
    
    private lazy var marketLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.marketName
        label.font = UIFont(name: Constants.Font.gothamMedium, size: Constants.Font.title)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hexString: Constants.mainBlue), for: .normal)
        button.setTitle(Constants.registerButtonName, for: .normal)
        return button
    }()
    
    private lazy var hidePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: Constants.showPasswordImageName), for: .normal)
        return button
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        subcribe()
        configureTextField(loginFieldView)
        configureTextField(passwordFieldView)
    }
    
    // MARK: - Init
    init(viewModel: any LoginViewModel) {
        self.viewModel = viewModel
        loginFieldView = TextFieldView(textFieldName: "login",
                                       textField: loginField,
                                       type: .onlyLetters)
        passwordFieldView = TextFieldView(textFieldName: "password",
                                          textField: passwordField,
                                          type: .password)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // MARK: - SetupUI
    override func setupUI() {
        super.setupUI()
        
        contentView.addSubview(marketLogo)
        marketLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constants.marketLogoTop)
            make.left.equalToSuperview().inset(Constants.marketLogoLeft)
            make.right.equalToSuperview().inset(Constants.marketLogoRight)
            make.height.equalTo(marketLogo.snp.width)
        }
        
        contentView.addSubview(marketLabel)
        marketLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(marketLogo.snp.bottom).offset(Constants.marketLabelTopOffset)
        }
        
        contentView.addSubview(loginFieldView)
        loginFieldView.snp.makeConstraints { make in
            make.top.equalTo(marketLabel.snp.bottom).offset(Constants.loginFieldViewTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
        }
        
        contentView.addSubview(passwordFieldView)
        passwordField.isSecureTextEntry = true
        passwordFieldView.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(Constants.passwordFieldViewTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
        }
        
        passwordFieldView.addSubview(hidePasswordButton)
        hidePasswordButton.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        hidePasswordButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.hidePasswordButtonBottomInset)
        }
        
        contentView.addSubview(filledButton)
        filledButton.updateAppearance(isEnabled: false)
        filledButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        filledButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(Constants.filledButtonTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
        }
        
        contentView.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(filledButton).offset(Constants.registerButtonTopOffset)
            make.bottom.equalToSuperview().inset(Constants.registerButtonBottomInset)
        }
        
        view.layoutIfNeeded()
    }

    
    // MARK: - Private methods
    private func configureTextField(_ view: UIView) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: view.frame.height - 1, width: view.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(hexString: "#C0C0C0").cgColor
        view.layer.addSublayer(bottomLine)
    }
    
    @objc func hidePassword() {
        passwordField.isSecureTextEntry.toggle()
        hidePasswordButton.setImage(UIImage(
            named: passwordField.isSecureTextEntry ? Constants.showPasswordImageName : Constants.hidePasswordImageName
        ), for: .normal)
    }
    
    private func subcribe() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: nil)
    }
    
    @objc private func textDidChange() {
        if loginField.text?.count ?? 0 > 5 && passwordField.text?.count ?? 0 > 5 {
            filledButton.updateAppearance(isEnabled: true)
        } else {
            filledButton.updateAppearance(isEnabled: false)
        }
    }
    
    @objc private func submit() {
    }
    
    @objc private func register() {
        showNotification(text: "dsjdakldsdjklas", type: .success)
        viewModel.sendEvent(.signUp)
    }
}

// MARK: - Events
extension LoginViewController {
    enum Event {
        case signIn
        case signUp
        case resetState
    }
}

// MARK: - Constants
fileprivate extension Constants {}
