import Foundation

//: [文章地址](https://mp.weixin.qq.com/s/qT31JPAERXJtE7zIdMYTCg)

// MARK: - 策略抽象类

protocol QRCodeScanStrategy {
    func deal(info: Any)
}

// MARK: - 策略具体实现

struct QRCodeScanLoginStrategy: QRCodeScanStrategy {
    func deal(info: Any) {
        print("QRCodeScanLoginStrategy处理信息：\(info)")
    }
}

struct QRCodeScanBusinessCardStrategy: QRCodeScanStrategy {
    func deal(info: Any) {
        print("QRCodeScanBusinessCardStrategy处理信息：\(info)")
    }
}

// MARK: - 策略上下文

/// 策略上下文
///
/// 策略上下文的一个重要作用是为策略之间的共同点提供一个承接的地方，比如共同使用的常量等等。
struct QRCodeScanContext {
    private var strategy: QRCodeScanStrategy?

    init(strategy: QRCodeScanStrategy) {
        self.strategy = strategy
    }

    public func deal(info: Any) {
        strategy?.deal(info: info)
    }
}

class QRCodeScanManager {
    public static func main() {
        let typeArr = ["login", "businessCard"]
        var context: QRCodeScanContext?

        // 更换type，切换使用不同策略
        let type = typeArr[0]

        switch type {
        case "login":
            context = QRCodeScanContext(strategy: QRCodeScanLoginStrategy())
        case "businessCard":
            context = QRCodeScanContext(strategy: QRCodeScanBusinessCardStrategy())
        default:
            break
        }
        context?.deal(info: "")
    }
}

QRCodeScanManager.main()
