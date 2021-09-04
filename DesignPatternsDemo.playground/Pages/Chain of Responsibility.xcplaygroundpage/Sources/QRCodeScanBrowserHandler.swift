import Foundation

public class QRCodeScanBrowserHandler: QRCodeScanHandler {
    public var nextHandler: QRCodeScanHandler?

    public func handle(info: Any?) -> Bool? {
        guard let urlStr = info as? String, let _ = URL(string: urlStr) else {
            return nextHandler?.handle(info: info)
        }
        print("网页链接码")
        return true
    }

    public init() {
        
    }
}
