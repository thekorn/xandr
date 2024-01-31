import AppNexusSDK
import Flutter
import UIKit

extension FlutterError: Swift.Error {}

public class XandrPlugin: UIViewController, FlutterPlugin,
  XandrHostApi {
  public static var instance: XandrPlugin?
  // private var isInitialized: Completer<SPUserData> = .init()
  private var flutterAPI: XandrFlutterApi?

  public static func register(with registrar: FlutterPluginRegistrar) {
    instance = XandrPlugin()
    instance?.onRegister(registrar)
  }

  public func onRegister(_ registrar: FlutterPluginRegistrar) {
    let messenger: FlutterBinaryMessenger = registrar.messenger()
    XandrHostApiSetup.setUp(binaryMessenger: messenger, api: self)
    flutterAPI = XandrFlutterApi(binaryMessenger: messenger)
  }

  func initXandrSdk(memberId: Int64, completion: @escaping (Result<Bool, Error>) -> Void) {
    DispatchQueue.main.async {
      XandrAd.sharedInstance().initWithMemberID(Int(memberId), preCacheRequestObjects: true) {
        success in
        if success {
          print("#### initialized Xandr SDK")
          completion(.success(true))
        } else {
          print("#### failed to initialize Xandr SDK")
          completion(.failure(NSError(
            domain: "XandrAd.sharedInstance().initWithMemberID",
            code: 1,
            userInfo: nil
          )))
        }
      }
    }
  }

  func loadInterstitialAd(widgetId: Int64, placementID: String?, inventoryCode: String?,
                          customKeywords: [String: String]?,
                          completion: @escaping (Result<Bool, Error>) -> Void) {
    print("#### loadInterstitialAd()")
  }

  func showInterstitialAd(autoDismissDelay: Int64?,
                          completion: @escaping (Result<Bool, Error>) -> Void) {
    print("#### showInterstitialAd()")
  }
}
