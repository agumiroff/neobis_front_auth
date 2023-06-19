//
//  Constants.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import Foundation

enum Constants {
    
    enum Font {
        static let gothamMedium = "GothamPro-Medium"
        
        static let title = 18.0
        static let regular = 16.0
        static let small = 12.0
    }
    
    // Colors
    static let mainBlue = "#5458EA"
    static let mainGray = "#C0C0C0"
    
    // Sizes
    static let borderWidth: CGFloat = 1
    static let submitButtonCornerRadius: CGFloat = 25
    
    // Constaints
    static let horizontalInsets: CGFloat = 20
    
    static let marketLogoTop: CGFloat = 16.0
    static let marketLogoLeft: CGFloat = 133.0
    static let marketLogoRight: CGFloat = 162.0
    
    static let marketLabelTopOffset: CGFloat = 8.0
    
    static let loginFieldViewTopOffset: CGFloat = 120.0
    
    static let passwordFieldViewTopOffset: CGFloat = 32.0
    
    static let hidePasswordButtonBottomInset: CGFloat = 10.0
    
    static let filledButtonTopOffset: CGFloat = 82.0
    
    static let registerButtonTopOffset: CGFloat = 183.0
    static let registerButtonBottomInset: CGFloat = 30.0
    
    // Strings
    static let title = "Войти"
    static let marketLogoImageName = "shopping-cart"
    static let registerButtonName = "Зарегистрироваться"
    static let loginFieldName = "login"
    static let passwordFieldName = "password"
    static let nameFieldName = "Имя пользователя"
    static let emailFieldName = "Почта"
    static let hidePasswordImageName = "hidePassword"
    static let showPasswordImageName = "showPassword"
    static let marketName = "MOBI MARKET"
    static let backButtonImageName = "backButton"
}
