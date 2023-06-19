//
//  NotificationView.swift
//  Marketplace
//
//  Created by G G on 16.06.2023.
//

import UIKit
import SnapKit

final class NotificationView: UIView {
    
    private let icon = UIImageView()
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: Constants.Font.gothamMedium, size: Constants.Font.regular)
        return label
    }()
    
    init() {
        super.init(frame: CGRect())
        backgroundColor = .clear
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.trailing.equalTo(label.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(text: String, type: NotificationType) {
        label.text = text
        icon.image = type == .success ? UIImage(named: "done") : UIImage(named: "exclamation")
        let bgColor = CALayer()
        bgColor.backgroundColor = type == .success ? UIColor(hexString: "#8FC53B").cgColor : UIColor.red.cgColor
        bgColor.frame = bounds
        bgColor.cornerRadius = bounds.height / 4
        bgColor.masksToBounds = true
        layer.insertSublayer(bgColor, at: 0)
    }
}

enum NotificationType {
    case success
    case failure
}
