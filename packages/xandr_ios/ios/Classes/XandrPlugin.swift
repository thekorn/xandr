import AppNexusSDK
import Flutter
import UIKit

extension FlutterError: Swift.Error {}

public class FlutterState {
  private var isInitialized: Completer<Bool> = .init()
  private var flutterAPI: XandrFlutterApi?
  public var memberId: Int!

  private var binaryMessenger: FlutterBinaryMessenger

  init(binaryMessenger: FlutterBinaryMessenger) {
    self.binaryMessenger = binaryMessenger
  }

  func startListening(api: XandrHostApi) {
    XandrHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: api)
    flutterAPI = XandrFlutterApi(binaryMessenger: binaryMessenger)
  }

  func stopListening() {
    XandrHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: nil)
  }

  public func setIsInitialized(success: Bool) {
    isInitialized.complete(result: success)
  }

  public func setIsInitializedCompletionHandler(handler: @escaping (Bool) -> Void) {
    isInitialized.setCompletionHandler(handler: handler)
  }
}

public class XandrPlugin: UIViewController, FlutterPlugin,
  XandrHostApi {
  public static var instance: XandrPlugin?

  public var flutterState: FlutterState?

  public static func register(with registrar: FlutterPluginRegistrar) {
    instance = XandrPlugin()
    instance?.onRegister(registrar)

    instance?.flutterState = FlutterState(binaryMessenger: registrar.messenger())

    let factory = XandrBannerFactory(
      messenger: registrar.messenger(),
      state: instance!.flutterState!
    )
    registrar.register(factory, withId: "de.thekorn.xandr/ad_banner")
  }

  public func onRegister(_ registrar: FlutterPluginRegistrar) {
    let messenger: FlutterBinaryMessenger = registrar.messenger()
    flutterState?.startListening(api: self)
  }

  func initXandrSdk(memberId: Int64, completion: @escaping (Result<Bool, Error>) -> Void) {
    DispatchQueue.main.async {
      XandrAd.sharedInstance()
        .initWithMemberID(Int(memberId), preCacheRequestObjects: true) { [self]
          success in
            if success {
              print("#### initialized Xandr SDK")
              flutterState?.memberId = Int(memberId)
              flutterState?.setIsInitialized(success: true)
              completion(.success(true))
            } else {
              print("#### failed to initialize Xandr SDK")
              flutterState?.memberId = Int(memberId)
              flutterState?.setIsInitialized(success: false)
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

class XandrBannerFactory: NSObject, FlutterPlatformViewFactory {
  private weak var messenger: FlutterBinaryMessenger?
  private var state: FlutterState

  init(messenger: FlutterBinaryMessenger, state: FlutterState) {
    self.messenger = messenger
    self.state = state
    super.init()
  }

  func create(withFrame frame: CGRect,
              viewIdentifier viewId: Int64,
              arguments args: Any?) -> FlutterPlatformView {
    XandrBanner(
      state: state,
      frame: frame,
      viewIdentifier: viewId,
      args: args,
      binaryMessenger: messenger
    )
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }
}

class XandrBanner: NSObject, FlutterPlatformView, ANBannerAdViewDelegate {
  private var banner: ANBannerAdView?

  init(state: FlutterState, frame: CGRect,
       viewIdentifier viewId: Int64,
       args: Any?,
       binaryMessenger messenger: FlutterBinaryMessenger?) {
    super.init()
    // Do any additional setup after loading the view.
    ANSDKSettings.sharedInstance().enableOMIDOptimization = true

    guard let arguments = args as? [String: Any] else {
      return
    }

    let inventoryCode = arguments["inventoryCode"] as? String
    let customKeywords = arguments["customKeywords"] as? [String]
    let adSizesArgs = arguments["adSizes"] as? [[String: Int]]

    var adSizes: [NSValue] = []
    adSizesArgs?.forEach { size in
      adSizes.append(NSValue(cgSize: CGSize(
        width: size["width"]! as Int,
        height: size["height"]! as Int
      )))
    }

    state.setIsInitializedCompletionHandler { [self] result in
      // Make a banner ad view.
      banner = ANBannerAdView(
        frame: frame,
        memberId: state.memberId!,
        inventoryCode: inventoryCode!
      )
      banner?.delegate = self
      customKeywords?.forEach { keyword in
        banner?.addCustomKeyword(withKey: "kw", value: keyword)
      }

      banner?.adSizes = adSizes
      banner?.loadAd()
    }
  }

  func view() -> UIView {
    banner!
  }
}
