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
    private let loginField = BaseTextField(textFieldName: "login")
    
    private lazy var marketLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shopping-cart")
        return imageView
    }()
    
    private lazy var marketLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.marketNameText
        return label
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Init
    init(viewModel: any LoginViewModel) {
        self.viewModel = viewModel
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
        
        contentView.addSubview(loginField)
        loginField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
            make.centerY.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension LoginViewController {
    enum Event {
        case sendGood
    }
}
