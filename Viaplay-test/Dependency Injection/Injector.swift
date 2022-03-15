//
//  Injector.swift
//  Viaplay-test
//
//  Created by Tim Gunnarsson on 2022-03-15.
//

import Foundation

@propertyWrapper
struct Injected<T> {
    private let keyPath: WritableKeyPath<InjectedValues, T>
    var wrappedValue: T {
        get { InjectedValues[keyPath] }
        set { InjectedValues[keyPath] = newValue }
    }
    
    init(_ keyPath: WritableKeyPath<InjectedValues, T>) {
        self.keyPath = keyPath
    }
}

protocol InjectionKey {

    associatedtype Value

    static var currentValue: Self.Value { get set }
}

private struct NetworkServiceKey: InjectionKey {
    static var currentValue: NetworkServiceProtocol = NetworkService()
}

struct InjectedValues {
    
    private static var current = InjectedValues()
    
    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

extension InjectedValues {
    var networkService: NetworkServiceProtocol {
        get { Self[NetworkServiceKey.self] }
        set { Self[NetworkServiceKey.self] = newValue }
    }
}
