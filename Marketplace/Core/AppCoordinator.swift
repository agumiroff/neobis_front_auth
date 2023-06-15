//
//  AppCoordinator.swift
//  MarketPlace
//
//  Created by G G on 15.06.2023.
//

import UIKit
import Combine

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    lazy var type: CoordinatorType = .app
    var navigationController: UINavigationController
    lazy var childCoordinators: [Coordinator] = []
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        startMainFlow()
    }
    
    // MARK: - private Methods
    
}

// MARK: - Flows
extension AppCoordinator {
    
    private func startMainFlow() {
        let view = ViewController()
        navigationController.pushViewController(view, animated: false)
//        let module = MovieAssembly.buildModule()
//        let view = module.view
//        let output = module.output
//
//        output.sink { output in
//            switch output {
//
//            }
//        }
//        .store(in: &cancellables)
//
//        navigationController.viewControllers = [view]
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        switch childCoordinator.type {
        case .app:
            navigationController.viewControllers.removeAll()
        case .auth:
            navigationController.viewControllers.removeAll()
        case .main:
            navigationController.viewControllers.removeAll()
        }
    }
}
