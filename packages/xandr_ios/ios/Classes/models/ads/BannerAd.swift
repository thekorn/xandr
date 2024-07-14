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

  func loadAd() {
    banner?.loadAd()
  }
}
