import Foundation

class QRCodeScanManager {
    private init() {}

    static let shared = QRCodeScanManager()

    private var handlerList: [QRCodeScanHandler] = [
        QRCodeScanLoginHandler(),
        QRCodeScanBusinessCardHandler(),
        QRCodeScanBrowserHandler(),
    ]

    private lazy var startHandler: QRCodeScanHandler? = {
        let count = handlerList.count
        if count <= 0 {
            return nil
        } else {
            if count > 1 {
                var startHandler = handlerList[0]
                for index in 1 ... count - 1 {
                    startHandler.setNext(handler: handlerList[index])
                    startHandler = handlerList[index]
                }
            }
            return handlerList[0]
        }
    }()

    func showScanResult() {
        let list: [Any] = [
            ["type": "login", "message": "登录"],
            ["type": "businessCard", "message": "名片"],
            "http://www.baidu.com",
            "123",
        ]
        // 切换类型
        let request = list[list.count - 2]
        guard let result = startHandler?.handle(info: request), result else {
            print("默认结果")
            print(request)
            return
        }
    }
}

QRCodeScanManager.shared.showScanResult()
