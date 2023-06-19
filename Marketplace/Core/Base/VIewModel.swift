//
//  VIewModel.swift
//  Marketplace
//
//  Created by G G on 16.06.2023.
//

import Foundation
import Combine

protocol ViewModel {
    associatedtype EventType: EventProtocol
    var event: AnyPublisher<EventType, Never> { get }
    func sendEvent(_ event: EventType)
}


protocol EventProtocol {
    // Здесь можно определить общие свойства и методы для всех типов событий
}
