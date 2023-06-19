//
//  FilledButton.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import UIKit
import Combine

final class FilledButton: UIButton {
    
    var title: String
    
    init(title: String) {
        self.title = title
        
        super.init(frame: CGRect())
        setupAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        updateAppearance(isEnabled: isEnabled)
        layer.cornerRadius = Constants.submitButtonCornerRadius
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont(name: Constants.Font.gothamMedium,
                                  size: Constants.Font.regular)
        contentEdgeInsets = UIEdgeInsets(top: 14.5,
                                         left: 0,
                                         bottom: 14.5,
                                         right: 0)
    }
    
    func updateAppearance(isEnabled: Bool) {
        backgroundColor = UIColor(hexString: isEnabled ? Constants.mainBlue : Constants.mainGray)
        setTitleColor(.white, for: .normal)
        self.isEnabled = isEnabled
    }
}
