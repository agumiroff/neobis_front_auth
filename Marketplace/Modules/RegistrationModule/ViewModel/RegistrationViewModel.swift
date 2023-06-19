//
//  RegistrationViewModel.swift
//  Marketplace
//
//  Created by G G on 16.06.2023.
//

import Foundation
import Combine

typealias RegistrationEvent = RegistrationViewController.Event
typealias RegistrationState = RegistrationViewModelImpl.State
typealias RegistrationOutput = RegistrationViewModelImpl.Output

protocol RegistrationViewModel {
    associatedtype InputType
    var input: InputType { get set }
    var output: AnyPublisher<RegistrationOutput, Never> { get }
    var state: AnyPublisher<RegistrationState, Never> { get }
    func sendEvent(_ event: RegistrationEvent)
}
