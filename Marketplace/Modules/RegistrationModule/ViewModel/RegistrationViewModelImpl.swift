//
//  RegistrationViewModelImpl.swift
//  Marketplace
//
//  Created by G G on 16.06.2023.
//

import Foundation
import Combine

final class RegistrationViewModelImpl: RegistrationViewModel {
    
    // MARK: - Properties
    var state: AnyPublisher<State, Never> {
        _state.eraseToAnyPublisher()
    }
    private var _state = CurrentValueSubject<State, Never>(.initial)
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

extension RegistrationViewModelImpl {
    enum State {
        case initial
    }
    
    enum Output {
        case registrationRouteAsked
    }
    
    func sendEvent(_ event: RegistrationEvent) { }
}
