public protocol BTScanner {
    init(decoders: [BTDecoder], services: [BTService])
    
    var bluetoothState: BTScannerState { get }
    
    @discardableResult
    func scan<T: AnyObject>(_ observer: T, options: BTScannerOptionsInfo?, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken
    @discardableResult
    func state<T: AnyObject>(_ observer: T, options: BTScannerOptionsInfo?, closure: @escaping (T, BTScannerState) -> Void) -> ObservationToken
    @discardableResult
    func lost<T: AnyObject>(_ observer: T, options: BTScannerOptionsInfo?, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken
    @discardableResult
    func observe<T: AnyObject>(_ observer: T, uuid: String, options: BTScannerOptionsInfo?, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken
    @discardableResult
    func connect<T: AnyObject>(_ observer: T, uuid: String, options: BTScannerOptionsInfo?, connected: @escaping (T) -> Void, disconnected: @escaping (T) -> Void) -> ObservationToken
}

public extension BTScanner {
    @discardableResult
    func scan<T: AnyObject>(_ observer: T, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken {
        return scan(observer, options: nil, closure: closure)
    }
    
    @discardableResult
    func state<T: AnyObject>(_ observer: T, closure: @escaping (T, BTScannerState) -> Void) -> ObservationToken {
        return state(observer, options: nil, closure: closure)
    }
    
    @discardableResult
    func lost<T: AnyObject>(_ observer: T, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken {
        return lost(observer, options: nil, closure: closure)
    }
    
    @discardableResult
    func observe<T: AnyObject>(_ observer: T, uuid: String, closure: @escaping (T, BTDevice) -> Void) -> ObservationToken {
        return observe(observer, uuid: uuid, options: nil, closure: closure)
    }
    
    @discardableResult
    func connect<T: AnyObject>(_ observer: T, uuid: String, connected: @escaping (T) -> Void, disconnected: @escaping (T) -> Void) -> ObservationToken {
        return connect(observer, uuid: uuid, options: nil, connected: connected, disconnected: disconnected)
    }
}

public enum BTScannerState : Int {
    case unknown
    case resetting
    case unsupported
    case unauthorized
    case poweredOff
    case poweredOn
}

