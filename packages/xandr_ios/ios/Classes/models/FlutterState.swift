//
//  FlutterState.swift
//  xandr_ios
//
//  Created by markus korn on 13.05.24.
//

import AppNexusSDK
import Flutter
import Foundation

private func logResult(_ result: Any?) {
  logger
    .debug(
      message: "flutter api: we got a result back from the flutter api \(String(describing: result))"
    )
}

public class FlutterState {
  public var isInitialized: Completer<Bool> = .init()
  private var flutterAPI: XandrFlutterApi?
  public var memberId: Int!
  public var publisherId: Int?
  private var flutterBannerAdviews: [Int64: XandrBanner] = [:]

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
    isInitialized.complete(success)
  }

  public func setIsInitializedCompletionHandler(handler: @escaping (Bool) -> Void) {
    isInitialized.invokeOnCompletion(handler)
  }

  func getOrCreateXandrBanner(frame: CGRect, id: Int64, args: Any?) -> XandrBanner {
    if flutterBannerAdviews[id] == nil {
      logger.debug(message: "Create new XandrBanner for widgetId=\(id)")
      flutterBannerAdviews[id] = XandrBanner(
        state: self,
        frame: frame,
        viewIdentifier: id,
        args: args,
        binaryMessenger: binaryMessenger
      )
    }

    logger.debug(message: "Return existing XandrBanner for widgetId=\(id)")
    return flutterBannerAdviews[id]!
  }

  func getXandrBanner(id: Int64) throws -> XandrBanner {
    if flutterBannerAdviews[id] != nil {
      logger.debug(message: "Return XandrBanner for widgetId=\(id)")
      return flutterBannerAdviews[id]!
    } else {
      logger.error(message: "XandrBanner for widgetId=\(id) not found!")
      throw XandrPluginError.runtimeError("Unable to find Banner for widgetId=\(id)")
    }
  }

  public func onAdLoadedAPI(viewId: Int64, width: CGFloat, height: CGFloat, creativeId: String,
                            adType: ANAdType, tagId: String, auctionId: String, cpm: Double,
                            memberId: Int) {
    let adTypeIndentifier = switch adType {
    case ANAdType.banner: "banner"
    case ANAdType.native: "native"
    case ANAdType.unknown: "unknown"
    case ANAdType.video: "video"
    @unknown default: "unknwon"
    }

    flutterAPI?.onAdLoaded(
      viewId: viewId,
      width: Int64(width),
      height: Int64(height),
      creativeId: creativeId,
      adType: adTypeIndentifier,
      tagId: tagId,
      auctionId: auctionId,
      cpm: cpm,
      memberId: Int64(memberId),
      completion: logResult
    )
  }
}
