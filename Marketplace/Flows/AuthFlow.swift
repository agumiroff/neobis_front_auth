//
//  AuthFlow.swift
//  Marketplace
//
//  Created by G G on 15.06.2023.
//

import Combine
import UIKit

final class AuthFlowCoordinator: Coordinator {
    // MARK: - Properties
    var type: CoordinatorType = .auth
    private var cancellables = Set<AnyCancellable>()
    var navigationController: UINavigationController
    var delegate: CoordinatorFinishDelegate
    var childCoordinators: [Coordinator] = []
    
    // MARK: Methods
    func start() {
        showWelcomeScreen()
    }
    
    func finish() {
        delegate.coordinatorDidFinish(childCoordinator: self)
    }
    
    // MARK: - Init
    init(navigationController: UINavigationController, delegate: CoordinatorFinishDelegate) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    // WelcomeScreen
    private func showWelcomeScreen() {
        let module = LoginModuleAssembly.buildModule(dependencies: .init(), payload: .init())
        let view = module.view
        module.output
            .sink { [weak self] output in
                guard let self else { return }
                switch output {
                case .registrationRouteAsked:
                    self.showRegistrationScreen()
                }
            }
            .store(in: &cancellables)
        
        navigationController.viewControllers = [view]
    }
    
    // RegistrationScreen
    private func showRegistrationScreen() {}
}
