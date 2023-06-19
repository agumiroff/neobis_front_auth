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
        case loading
    }
    
    enum Output {
        case registrationRouteAsked
    }
    
    func sendEvent(_ event: LoginEvent) {
        switch event {
        case .signIn:
            break
        case .signUp:
            _output.send(.registrationRouteAsked)
        case .resetState:
            _state.send(.initial)
        }
    }
}

//final class Binder {
//    private var listener: ((LoginState) -> Void)?
//
//    var value: LoginState {
//        didSet { fireOnMainThread() }
//    }
//
//    init(_ value: LoginState) {
//        self.value = value
//    }
//
//    func bind(_ listener: @escaping (LoginState) -> Void) {
//        self.listener = listener
//        fireOnMainThread()
//    }
//
//    private func fireOnMainThread() {
//        DispatchQueue.main.async { [weak self] in
//            guard let self, let listener = self.listener else { return }
//            listener(self.value)
//        }
//    }
//}
