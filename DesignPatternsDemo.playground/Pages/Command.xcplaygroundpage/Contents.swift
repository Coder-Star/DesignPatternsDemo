
/**
 命令模式在AppDelegate解耦场景下的应用
 */

import UIKit

// MARK: - 命令接口
protocol AppDelegateDidFinishLaunchingCommand {
    func execute()
}

// MARK: - 初始化三方命令
struct InitializeThirdPartiesCommand: AppDelegateDidFinishLaunchingCommand {
    func execute() {
        print("InitializeThirdPartiesCommand 触发")
    }
}

// MARK: - 初始化rootViewController
struct InitialViewControllerCommand: AppDelegateDidFinishLaunchingCommand {
    let keyWindow: UIWindow

    func execute() {
        print("InitialViewControllerCommand 触发")
        keyWindow.rootViewController = UIViewController()
    }
}

// MARK: - 命令构造器
final class AppDelegateCommandsBuilder {
    private var window: UIWindow!

    func setKeyWindow(_ window: UIWindow) -> AppDelegateCommandsBuilder {
        self.window = window
        return self
    }

    func build() -> [AppDelegateDidFinishLaunchingCommand] {
        return [
            InitializeThirdPartiesCommand(),
            InitialViewControllerCommand(keyWindow: window),
        ]
    }
}

// MARK: - AppDelegate
/// 充当发送者、客户端的作用
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()

        AppDelegateCommandsBuilder()
            .setKeyWindow(window!)
            .build()
            .forEach { $0.execute() }
        return true
    }
}


// MARK: - 手动调用
AppDelegate().application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
