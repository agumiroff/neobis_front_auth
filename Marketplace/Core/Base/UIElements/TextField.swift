//
//  TextField.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import UIKit
import SnapKit

final class BaseTextField: UIView {
    
    // MARK: - Properties
    private var textFieldName: String
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0,
                                  y: textField.frame.size.height - Constants.borderWidth,
                                  width: textField.frame.size.width,
                                  height: Constants.borderWidth)
        bottomLine.backgroundColor = UIColor.black.cgColor
        textField.layer.addSublayer(bottomLine)
        return textField
    }()
    
    private lazy var textFieldLabel: UILabel = {
        let label = UILabel()
        label.text = "dsdsddsds"
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    init(textFieldName: String) {
        self.textFieldName = textFieldName
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        
        addSubview(textFieldLabel)
        self.textField.placeholder = textFieldName
        textFieldLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldLabel.snp.bottom).offset(Constants.textFieldTop)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

fileprivate extension Constants {
        
    // Constraints
    static let textFieldTop: CGFloat = 12.5
    
    // Other
    static let borderWidth: CGFloat = 1
}
