import Flutter
import UIKit

public class XandrPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "xandr_ios", binaryMessenger: registrar.messenger())
        let instance = XandrPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS")
    }
}
