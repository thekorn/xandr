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

    let adSizesArgs = arguments["adSizes"] as? [[String: Int]]
    let customKeywords = arguments["customKeywords"] as? [String: [String]]
    // let layoutHeight = arguments["layoutHeight"] as? Int
    // let layoutWidth = arguments["layoutWidth"] as? Int
    // let shouldServePSAs = arguments["shouldServePSAs"] as? Bool ?? false
    // let loadsInBackground = arguments["loadsInBackground"] as? Bool ?? false
    let resizeAdToFitContainer = arguments["resizeAdToFitContainer"] as? Bool ?? false
    let placementID = arguments["placementID"] as? String
    // let memberId = arguments["memberId"] as? String //<--- taken from state
    let inventoryCode = arguments["inventoryCode"] as? String
    // let clickThroughAction = arguments["clickThroughAction"] as? String
    let autoRefreshInterval = arguments["autoRefreshInterval"] as? Double ?? 30
    // let resizeWhenLoaded = arguments["resizeWhenLoaded"] as? Bool ?? false
    let allowNativeDemand = arguments["allowNativeDemand"] as? Bool ?? false
    // let loadWhenCreated = arguments["loadWhenCreated"] as? Bool ?? false
    let enableLazyLoad = arguments["enableLazyLoad"] as? Bool ?? false
    // let multiAdRequestId = arguments["multiAdRequestId"] as? String

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
      banner?.shouldResizeAdToFitContainer = resizeAdToFitContainer
      banner?.autoRefreshInterval = autoRefreshInterval
      banner?.shouldAllowNativeDemand = allowNativeDemand
      banner?.enableLazyLoad = enableLazyLoad

      if inventoryCode != nil {
        banner?.setInventoryCode(inventoryCode, memberId: state.memberId)
      } else {
        banner?.placementId = placementID
      }

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

  func ad(_ ad: Any, requestFailedWithError error: any Error) {
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
      logger.error(message: "BannerAd.adDidRecieveAd: an error \(error)")
      state?.onAdLoadedError(viewId: viewId, reason: error.localizedDescription)
    }
  }
}
