//
//  NetworkObserver.swift
//  Flick
//
//  Created by JOSEPH AKINDE-PETERS on 29.12.2022.
//

import Foundation
import Network

class NetworkObserver: ObservableObject {
    @Published private(set) var isConnected: Bool = false
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    
    public func start() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }
    
    public func stop() {
        monitor.cancel()
    }
}
