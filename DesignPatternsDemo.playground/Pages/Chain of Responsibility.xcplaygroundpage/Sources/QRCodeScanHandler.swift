import Foundation

public protocol QRCodeScanHandler: AnyObject {
    var nextHandler: QRCodeScanHandler? { get set }

    @discardableResult
    func setNext(handler: QRCodeScanHandler) -> QRCodeScanHandler

    func handle(info: Any?) -> Bool?
}

// MARK: - 协议的默认实现

extension QRCodeScanHandler {
    ///
    public func setNext(handler: QRCodeScanHandler) -> QRCodeScanHandler {
        nextHandler = handler
        return handler
    }

    public func handle(info: Any?) -> Bool? {
        return nextHandler?.handle(info: info)
    }
}
