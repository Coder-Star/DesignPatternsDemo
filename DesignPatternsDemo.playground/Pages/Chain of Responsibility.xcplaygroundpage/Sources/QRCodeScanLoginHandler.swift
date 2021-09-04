import Foundation

public class QRCodeScanLoginHandler: QRCodeScanHandler {
    public var nextHandler: QRCodeScanHandler?

    public func handle(info: Any?) -> Bool? {
        guard let dict = info as? [String: String], let type = dict["type"], type == "login" else {
            return nextHandler?.handle(info: info)
        }
        print("登录码")
        return true
    }

    public init() {

    }
}
