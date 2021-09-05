/**
 策略模式在扫码场景下的使用
 */

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
/// 并且上下文是算法提供一类功能的方式，如不同算法可分别提供两个方法，提供两个上下文，每个上下文中都只有一个执行方法，这样可以将算法按照提供的功能进行聚合
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
