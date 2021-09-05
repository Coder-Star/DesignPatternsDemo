/**
 中介者模式在AppDelegate解耦场景下的应用
 */

import UIKit

// MARK: - 生命周期事件接口
protocol AppLifecycleListener {
    func onAppWillEnterForeground()
    func onAppDidEnterBackground()
    func onAppDidFinishLaunching()
}

// MARK: - 接口默认实现，使实现类可以对方法进行可选实现
extension AppLifecycleListener {
    func onAppWillEnterForeground() {}
    func onAppDidEnterBackground() {}
    func onAppDidFinishLaunching() {}
}

// MARK: - 实现类
class AppLifecycleListenerImp1: AppLifecycleListener {
    func onAppDidEnterBackground() {

    }
}

class AppLifecycleListenerImp2: AppLifecycleListener {
    func onAppDidEnterBackground() {

    }
}

// MARK: - 中介者
class AppLifecycleMediator: NSObject {
    private let listeners: [AppLifecycleListener]

    init(listeners: [AppLifecycleListener]) {
        self.listeners = listeners
        super.init()
        subscribe()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    /// 订阅生命周期事件
    private func subscribe() {
        NotificationCenter.default.addObserver(self, selector: #selector(onAppWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAppDidFinishLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
    }

    @objc private func onAppWillEnterForeground() {
        listeners.forEach { $0.onAppWillEnterForeground() }
    }

    @objc private func onAppDidEnterBackground() {
        listeners.forEach { $0.onAppDidEnterBackground() }
    }

    @objc private func onAppDidFinishLaunching() {
        listeners.forEach { $0.onAppDidFinishLaunching() }
    }

    // MARK: - 如需增加新的Listener，修改此处即可
    public static func makeDefaultMediator() -> AppLifecycleMediator {
        let listener1 = AppLifecycleListenerImp1()
        let listener2 = AppLifecycleListenerImp2()
        return AppLifecycleMediator(listeners: [listener1, listener2])
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    /// 构建监听者，内部自动订阅生命周期通知
    let mediator = AppLifecycleMediator.makeDefaultMediator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}
