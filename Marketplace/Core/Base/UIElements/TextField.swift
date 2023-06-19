//
//  TextField.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import UIKit
import SnapKit

final class TextFieldView: UIView {
    
    // MARK: - Properties
    private var textFieldName: String
    private let textField: UITextField
    private let type: FieldType
    
    private lazy var textFieldLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "#C0C0C0")
        return label
    }()
    
    private let paddingForText = UIEdgeInsets(top: 32,
                                              left: 10,
                                              bottom: 9,
                                              right: 30)
    
    // MARK: - Init
    init(textFieldName: String, textField: UITextField, type: FieldType) {
        self.textFieldName = textFieldName
        self.textField = textField
        self.type = type
        super.init(frame: CGRect())
        textField.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        
        addSubview(textFieldLabel)
        self.textFieldLabel.text = textFieldName
        textFieldLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        addSubview(textField)
        self.textField.placeholder = textFieldName
        textFieldLabel.isHidden = true
        textField.snp.makeConstraints { make in
            make.top.equalTo(textFieldLabel.snp.bottom).offset(Constants.textFieldTop)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.textFieldbottom)
        }
    }
}

extension TextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldLabel.isHidden = false
        textField.placeholder = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            textFieldLabel.isHidden = true
            textField.placeholder = textFieldName
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch type {
        case .onlyLetters, .password:
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return characterSet.isSubset(of: allowedCharacters) || string.isEmpty
        case .email:
            break
        }
        return true
    }
}

fileprivate extension Constants {
        
    // Constraints
    static let textFieldTop: CGFloat = 12.5
    static let textFieldbottom: CGFloat = 10.5
}

extension TextFieldView {
    enum FieldType {
        case onlyLetters
        case password
        case email
    }
}
