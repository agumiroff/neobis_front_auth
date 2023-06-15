//
//  LoginVMImpl.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import Foundation
import Combine



class LoginViewModelImpl: LoginViewModel {
    
    // MARK: - Properties
    var state: AnyPublisher<LoginState, Never> {
        _state.eraseToAnyPublisher()
    }
    private var _state = CurrentValueSubject<LoginState, Never>(.initial)
    var output: AnyPublisher<Output, Never> {
        _output.eraseToAnyPublisher()
    }
    private var _output = PassthroughSubject<Output, Never>()
    var input: Input
    
    struct Input {}
    
    init(input: Input) {
        self.input = input
    }
}

extension LoginViewModelImpl {
    enum State {
        case initial
    }
    
    enum Output {
        case registrationRouteAsked
    }
    
    func sendEvent(_ event: LoginEvent) {
        
    }
}
