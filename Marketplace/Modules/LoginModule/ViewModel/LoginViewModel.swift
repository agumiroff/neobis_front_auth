//
//  LoginVM.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import Foundation
import Combine

typealias LoginEvent = LoginViewController.Event
typealias LoginState = LoginViewModelImpl.State
typealias LoginOutput = LoginViewModelImpl.Output

protocol LoginViewModel {
    associatedtype InputType
    var input: InputType { get }
    var output: AnyPublisher<LoginOutput, Never> { get }
    var state: AnyPublisher<LoginState, Never> { get }
    func sendEvent(_ event: LoginEvent)
    var gState: Binder { get }
}
