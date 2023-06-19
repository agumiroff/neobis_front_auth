//
//  RegistrationModuleAssembly.swift
//  Marketplace
//
//  Created by G G on 16.06.2023.
//

import Foundation
import Combine

typealias RegistrationModule = (view: RegistrationViewController, output: AnyPublisher<RegistrationOutput, Never>)

enum RegistrationModuleAssembly {
        
    struct Dependencies {}
    
    struct PayLoad {}
    
    static func buildModule(dependencies: Dependencies, payload: PayLoad) -> RegistrationModule {
        let viewModel = RegistrationViewModelImpl(input: .init())
        let view = RegistrationViewController(viewModel: viewModel)
        return (view, viewModel.output)
    }
}
