//
//  BaseViewController.swift
//  MarketPlace
//
//  Created by G G on 15.06.2023.
//

import UIKit
import Combine
import SnapKit

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    let scrollView = UIScrollView()
    let contentView = UIView()
    var notificationView = NotificationView()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetup()
        notificationView.transform = CGAffineTransform(translationX: 0,
                                                       y: -notificationView.bounds.height)
    }
    
    func setupUI() {
        
        keyboardNotificationSetup()
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = .zero
        scrollView.bounces = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalTo(scrollView.snp.width)
        }
        
        scrollView.addSubview(notificationView)
        notificationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInsets)
            make.height.equalTo(60)
        }
    }
    
    func navigationSetup() {
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - SetupViews
extension BaseViewController {
    
    private func keyboardNotificationSetup() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardDidDissappear),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self, selector: #selector(keyboarDidAppear),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }
    
    @objc func keyboarDidAppear(notification: Notification) {
        guard let info = notification.userInfo,
              let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        let bottomPadding = view.safeAreaInsets.bottom
        let obscuredFrame = CGRect(x: 0,
                                   y: self.view.frame.height - keyboardFrame.height - bottomPadding,
                                   width: self.view.frame.width,
                                   height: keyboardFrame.height + bottomPadding)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        if obscuredFrame.intersects(self.contentView.frame) {
            scrollView.scrollRectToVisible(self.contentView.frame, animated: true)
        }
    }
    
    @objc func keyboardDidDissappear(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    func showNotification(text: String, type: NotificationType) {
        self.notificationView.configure(text: text, type: type)
        UIView.animate(withDuration: 1,
                       delay: 0) { [notificationView] in
            notificationView.transform = CGAffineTransform.identity
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            UIView.animate(withDuration: 1,
                           delay: 0.0,
                           options: .transitionFlipFromTop) { [weak self] in
                guard let self else { return }
                self.notificationView.transform = CGAffineTransform(translationX: 0,
                                                                    y: -notificationView.bounds.height)
            }
        })
    }
}
