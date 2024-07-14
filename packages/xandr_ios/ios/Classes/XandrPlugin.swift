import AppNexusSDK
import Flutter
import UIKit

extension FlutterError: Swift.Error {}

var logger = Logger(category: "XandrPlugin")

enum XandrPluginError: Error {
  case notValidSource
  case noMemberId
}

public class XandrPlugin: UIViewController, FlutterPlugin,
  XandrHostApi {
  public static var instance: XandrPlugin?

  public var flutterState: FlutterState?

  private var interstitialAd: InterstitialAd?

  private var marRegistry: MultiAdRequestRegistry = .init()

  public static func register(with registrar: FlutterPluginRegistrar) {
    // init the plugin and call onRegister
    logger.debug(message: "register plugin instance")
    instance = XandrPlugin()
    instance?.onRegister(registrar: registrar)
  }

  public func onRegister(registrar: FlutterPluginRegistrar) {
    // setup the state, start listening on the host api instance and register the banner factory
    logger.debug(message: "onRegister plugin instance")

    ANSDKSettings.sharedInstance().enableTestMode = true

    flutterState = FlutterState(binaryMessenger: registrar.messenger())
    flutterState?.startListening(api: self)

    let factory = XandrBannerFactory(
      messenger: registrar.messenger(),
      state: flutterState!
    )
    registrar.register(factory, withId: "de.thekorn.xandr/ad_banner")
  }

  func initXandrSdk(memberId: Int64, publisherId: Int64?,
                    completion: @escaping (Result<Bool, Error>) -> Void) {
    // init thge xandr sdk and store the memberId in the state on success
    // return true on success
    logger.debug(message: "initXandrSdk")
    DispatchQueue.main.async {
      XandrAd.sharedInstance()
        .initWithMemberID(Int(memberId), preCacheRequestObjects: true) { [self]
          success in
            if success {
              logger.debug(message: "initXandrSdk was successfull")
              flutterState?.memberId = Int(memberId)
              if publisherId != nil {
                flutterState?.publisherId = Int(publisherId!)
              }
              flutterState?.setIsInitialized(success: true)
              completion(.success(true))
            } else {
              logger.debug(message: "initXandrSdk failed")
              flutterState?.memberId = Int(memberId)
              if publisherId != nil {
                flutterState?.publisherId = Int(publisherId!)
              }
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

  func loadAd(widgetId: Int64, completion: @escaping (Result<Bool, any Error>) -> Void) {
    logger.debug(message: "load Ad for widgetId=\(widgetId)")
    completion(.success(true))
  }

  func loadInterstitialAd(widgetId: Int64, placementID: String?, inventoryCode: String?,
                          customKeywords: [String: [String]]?,
                          completion: @escaping (Result<Bool, Error>) -> Void) {
    interstitialAd = InterstitialAd()
    interstitialAd!.delegate = self

    customKeywords?.forEach { keyword in
      for value in keyword.value {
        interstitialAd?.addCustomKeyword(withKey: keyword.key, value: value)
      }
    }

    flutterState?.setIsInitializedCompletionHandler(handler: { _ in
      if self.flutterState?.memberId != nil {
        self.interstitialAd?.setInventoryCode(inventoryCode, memberId: self.flutterState!.memberId)
      } else if placementID != nil {
        self.interstitialAd?.placementId = placementID
      }
      self.interstitialAd?.load()
      logger.debug(message: "Xandr.Interstitial Loading DONE")

      self.interstitialAd?.isLoaded.invokeOnCompletion { _ in
        completion(Result.success(self.interstitialAd!.isLoaded.getCompleted()!))
      }
    })
  }

  func showInterstitialAd(autoDismissDelay: Int64?,
                          completion: @escaping (Result<Bool, Error>) -> Void) {
    if interstitialAd?.isClosed.isCompleted ?? false {
      completion(Result.success(false))
      return
    }

    if !(interstitialAd?.isReady ?? false) {
      completion(Result.success(false))
      return
    }

    interstitialAd?.isLoaded.invokeOnCompletion { _ in
      if autoDismissDelay == nil {
        self.interstitialAd?.display(from: self)
      } else {
        self.interstitialAd?.display(from: self, autoDismissDelay: Double(autoDismissDelay!))
      }
    }

    interstitialAd?.isClosed.invokeOnCompletion { _ in
      completion(Result.success(self.interstitialAd!.isClosed.getCompleted()!))
    }
  }

  func initMultiAdRequest(completion: @escaping (Result<String, Error>) -> Void) {
    guard let memberId = flutterState?.memberId else {
      completion(Result.failure(XandrPluginError.noMemberId))
      return
    }
    let mar: ANMultiAdRequest?
    if flutterState?.publisherId != nil {
      mar = ANMultiAdRequest(
        memberId: memberId,
        publisherId: (flutterState?.publisherId)!,
        andDelegate: self
      )
    } else {
      mar = ANMultiAdRequest(memberId: memberId, andDelegate: self)
    }
    if mar == nil {
      completion(Result.failure(XandrPluginError.noMemberId))
      return
    }
    let id = marRegistry.initNewRequest(mar!)
    completion(Result.success(id))
  }

  func disposeMultiAdRequest(multiAdRequestID: String,
                             completion: @escaping (Result<Bool, Error>) -> Void) {
    let result = marRegistry.removeRequestWithId(multiAdRequestID)
    completion(Result.success(result))
  }

  func loadAdsForMultiAdRequest(multiAdRequestID: String,
                                completion: @escaping (Result<Bool, Error>) -> Void) {
    let result = marRegistry.load(multiAdRequestID)
    completion(Result.success(result))
  }

  func setPublisherUserId(publisherUserId: String,
                          completion: @escaping (Result<Bool, Error>) -> Void) {
    ANSDKSettings.sharedInstance().publisherUserId = publisherUserId
    completion(Result.success(true))
  }

  func getPublisherUserId(completion: @escaping (Result<String, Error>) -> Void) {
    completion(Result.success(ANSDKSettings.sharedInstance().publisherUserId ?? ""))
  }

  func setUserIds(userIds: [HostAPIUserId],
                  completion: @escaping (Result<Bool, Error>) -> Void) {
    var uIds: [ANUserId] = []
    for it in userIds {
      var newId = ANUserId(anUserIdSource: it.source.toANUserIdSource(), userId: it.userId)
      if newId != nil {
        uIds.append(newId!)
      }
    }
    ANSDKSettings.sharedInstance().userIdArray = uIds
    completion(Result.success(true))
  }

  func getUserIds(completion: @escaping (Result<[HostAPIUserId], Error>) -> Void) {
    var userIds: [HostAPIUserId] = []
    ANSDKSettings.sharedInstance().userIdArray?.forEach { it in
      do {
        var newUserIds = try HostAPIUserId(
          source: it.source.toHostAPIUserIdSource(),
          userId: it.userId
        )
        userIds.append(newUserIds)
      } catch {
        logger.debug(message: "no valid user source")
      }
    }
    completion(Result.success(userIds))
  }

  func setGDPRConsentRequired(isConsentRequired: Bool,
                              completion: @escaping (Result<Bool, Error>) -> Void) {
    ANGDPRSettings.setConsentRequired(isConsentRequired ? 1 : 0)
    completion(Result.success(true))
  }

  func setGDPRConsentString(consentString: String,
                            completion: @escaping (Result<Bool, Error>) -> Void) {
    ANGDPRSettings.setConsentString(consentString)
    completion(Result.success(true))
  }

  func setGDPRPurposeConsents(purposeConsents: String,
                              completion: @escaping (Result<Bool, Error>) -> Void) {
    ANGDPRSettings.setPurposeConsents(purposeConsents)
    completion(Result.success(true))
  }
}

extension HostAPIUserIdSource {
  func toANUserIdSource() -> ANUserIdSource {
    switch self {
    case .criteo: ANUserIdSource.criteo
    case .theTradeDesk:
      ANUserIdSource.theTradeDesk
    case .netId:
      ANUserIdSource.netId
    case .liveramp:
      ANUserIdSource.liveRamp
    case .uid2:
      ANUserIdSource.UID2
    }
  }
}

extension String {
  func toHostAPIUserIdSource() throws -> HostAPIUserIdSource {
    switch self {
    case "criteo.com":
      HostAPIUserIdSource.criteo
    case "uidapi.com":
      HostAPIUserIdSource.uid2
    case "netid.de":
      HostAPIUserIdSource.netId
    case "liveramp.com":
      HostAPIUserIdSource.liveramp
    case "adserver.org":
      HostAPIUserIdSource.liveramp
    default:
      throw XandrPluginError.notValidSource
    }
  }
}

// ANInterstitialAdDelegate
extension XandrPlugin: ANInterstitialAdDelegate {
  public func adDidReceiveAd(_ ad: Any) {
    interstitialAd?.isLoaded.complete(true)
  }

  public func adDidClose(_ ad: Any) {
    interstitialAd?.isClosed.complete(true)
  }
}

// ANMultiAdRequestDelegate
extension XandrPlugin: ANMultiAdRequestDelegate {
  public func multiAdRequestDidComplete(_ mar: ANMultiAdRequest) {
    logger.debug(message: "Xandr.MultiAdRequest completed")
  }

  public func multiAdRequestDidFailWithError(_ error: NSError) {
    logger.debug(message: "Xandr.MultiAdRequest failed")
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
    logger.debug(message: "create banner")
    return XandrBanner(
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
    logger.debug(message: "init banner")

    guard let arguments = args as? [String: Any] else {
      return
    }

    let inventoryCode = arguments["inventoryCode"] as? String
    let customKeywords = arguments["customKeywords"] as? [String: [String]]
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
      customKeywords?.forEach { item in
        for value in item.value {
          banner?.addCustomKeyword(withKey: item.key, value: value)
        }
      }
      if state.publisherId != nil {
        banner?.publisherId = state.publisherId!
      }

      banner?.adSizes = adSizes
      logger.debug(message: "init banner, load ad...")
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
