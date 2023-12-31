//
//  Coordinator.swift
//  MarketPlace
//
//  Created by G G on 15.06.2023.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var type: CoordinatorType { get }
    func start()
}

enum CoordinatorType {
    case app
    case auth
    case main
}

// MARK: Finish coordinator states
protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
