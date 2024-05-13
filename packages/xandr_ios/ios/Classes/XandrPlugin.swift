import AppNexusSDK
import Flutter
import UIKit

extension FlutterError: Swift.Error {}

var logger = Logger(category: "XandrPlugin")

public class XandrPlugin: UIViewController, FlutterPlugin,
  XandrHostApi {
  public static var instance: XandrPlugin?

  public var flutterState: FlutterState?

  public static func register(with registrar: FlutterPluginRegistrar) {
    // init the plugin and call onRegister
    logger.debug(message: "register plugin instance")
    instance = XandrPlugin()
    instance?.onRegister(registrar: registrar)
  }

  public func onRegister(registrar: FlutterPluginRegistrar) {
    // setup the state, start listening on the host api instance and register the banner factory
    logger.debug(message: "onRegister plugin instance")

    flutterState = FlutterState(binaryMessenger: registrar.messenger())
    flutterState?.startListening(api: self)

    let factory = XandrBannerFactory(
      messenger: registrar.messenger(),
      state: flutterState!
    )
    registrar.register(factory, withId: "de.thekorn.xandr/ad_banner")
  }

  func initXandrSdk(memberId: Int64, completion: @escaping (Result<Bool, Error>) -> Void) {
    // init thge xandr sdk and store the memberId in the state on success
    // return true on success
    logger.debug(message: "initXnadrSdk")
    DispatchQueue.main.async {
      XandrAd.sharedInstance()
        .initWithMemberID(Int(memberId), preCacheRequestObjects: true) { [self]
          success in
            if success {
              logger.debug(message: "initXnadrSdk was successfull")
              flutterState?.memberId = Int(memberId)
              flutterState?.setIsInitialized(success: true)
              completion(.success(true))
            } else {
              logger.debug(message: "initXnadrSdk failed")
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
    logger.error(message: "loadInterstitialAd() not implemented")
  }

  func showInterstitialAd(autoDismissDelay: Int64?,
                          completion: @escaping (Result<Bool, Error>) -> Void) {
    logger.error(message: "showInterstitialAd() not implemented")
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
    guard let temp = banner else {
      logger.error(message: "banner is not initialized")
      return UIView()
    }
    return temp
  }
}
