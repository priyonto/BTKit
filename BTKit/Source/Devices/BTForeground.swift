public struct BTForeground {
    let scanner: BTScanner = BTScanneriOS(decoders: [RuuviDecoderiOS()],
                                          services: [RuuviNUSService()])
    
    public var bluetoothState: BTScannerState { return scanner.bluetoothState }
    
    @discardableResult
    public func scan<T: AnyObject>(_ observer: T, options: BTScannerOptionsInfo? = nil, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken {
        return scanner.scan(observer, options: options, closure: closure)
    }
    
    @discardableResult
    public func state<T: AnyObject>(_ observer: T, options: BTScannerOptionsInfo? = nil, closure: @escaping (T, BTScannerState) -> Void) -> ObservationToken {
        return scanner.state(observer, options: options, closure: closure)
    }
    
    @discardableResult
    public func lost<T: AnyObject>(_ observer: T, options: BTScannerOptionsInfo? = nil, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken {
        return scanner.lost(observer, options: options, closure: closure)
    }
    
    @discardableResult
    public func observe<T: AnyObject>(_ observer: T, uuid: String, options: BTScannerOptionsInfo? = nil, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken {
        return scanner.observe(observer, uuid: uuid, options: options, closure: closure)
    }
}