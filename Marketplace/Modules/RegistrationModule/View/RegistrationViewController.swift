//
//  RegistrationViewController.swift
//  Marketplace
//
//  Created by G G on 16.06.2023.
//

import UIKit
import SnapKit

final class RegistrationViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel: any RegistrationViewModel
    private let nameField = UITextField()
    private let emailField = UITextField()
    private var nameFieldView: TextFieldView
    private var emailFieldView: TextFieldView
    private let filledButton = FilledButton(title: Constants.title)
    
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
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        subcribe()
        configureTextField(nameFieldView)
        configureTextField(emailFieldView)
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Init
    init(viewModel: any RegistrationViewModel) {
        self.viewModel = viewModel
        nameFieldView = TextFieldView(textFieldName: Constants.nameFieldName,
                                      textField: nameField,
                                      type: .onlyLetters)
        emailFieldView = TextFieldView(textFieldName: Constants.emailFieldName,
                                       textField: emailField,
                                       type: .email)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - NavigationSetup
    override func navigationSetup() {
        super.navigationSetup()
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.title = Constants.registrationNavigationName
        let backButtonImage = UIImage(named: Constants.backButtonImageName)?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: backButtonImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
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
        
        contentView.addSubview(nameFieldView)
        nameFieldView.snp.makeConstraints { make in
            make.top.equalTo(marketLabel.snp.bottom).offset(Constants.loginFieldViewTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
        }
        
        contentView.addSubview(emailFieldView)
        emailFieldView.snp.makeConstraints { make in
            make.top.equalTo(nameField.snp.bottom).offset(Constants.passwordFieldViewTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
        }
        
        contentView.addSubview(filledButton)
        filledButton.updateAppearance(isEnabled: false)
        filledButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        filledButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(Constants.filledButtonTopOffset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
            make.bottom.equalToSuperview()
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
    
    private func subcribe() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(textDidChange),
                                               name: UITextField.textDidChangeNotification,
                                               object: nil)
    }
    
    @objc private func textDidChange() {
        guard let name = nameField.text, let email = emailField.text else { return }
        if name.count > 5 && email.count > 5 && email.isValidEmail() {
            filledButton.updateAppearance(isEnabled: true)
        } else {
            filledButton.updateAppearance(isEnabled: false)
        }
    }
    
    @objc private func submit() { }
    
    @objc private func backAction() {}
}

// MARK: - Events
extension RegistrationViewController {
    enum Event {
        case checkCredentials
    }
}

fileprivate extension Constants {
    
    // Strings
    static let registrationNavigationName = "Регистрация"
}
