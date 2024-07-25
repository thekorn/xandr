//
//  BannerAd.swift
//  xandr_ios
//
//  Created by markus korn on 14.07.24.
//

import AppNexusSDK
import Flutter
import Foundation

class XandrBanner: NSObject, FlutterPlatformView, ANBannerAdViewDelegate {
  public var banner: ANBannerAdView?
  public var state: FlutterState?
  public var viewId: Int64

  init(state: FlutterState, frame: CGRect,
       viewIdentifier viewId: Int64,
       args: Any?,
       binaryMessenger messenger: FlutterBinaryMessenger?) {
      self.viewId = viewId
    super.init()
    // Do any additional setup after loading the view.
    ANSDKSettings.sharedInstance().enableOMIDOptimization = true
    logger.debug(message: "init banner")
    self.state = state

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
      // banner?.appEventDelegate = self
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

  func loadAd() {
    banner?.loadAd()
  }

  public func adDidReceiveAd(_ ad: Any) {
    if ad is ANBannerAdView {
      let a = ad as? ANBannerAdView
      if let info = a?.adResponseInfo {
        state?.onAdLoadedAPI(
          viewId: viewId,
          width: a!.loadedAdSize.width,
          height: (a?.loadedAdSize.height)!,
          creativeId: info.creativeId!,
          adType: info.adType,
          tagId: "",
          auctionId: info.auctionId!,
          cpm: info.cpm!.doubleValue,
          memberId: info.memberId
        )

      } else {
        logger
          .error(
            message: "BannerAd.adDidRecieveAd: we did not get an adResponseInfo back, got \(String(describing: a))"
          )
      }
    } else {
      logger.error(message: "BannerAd.adDidRecieveAd: recieved an unknown payload \(ad)")
    }
  }
}
