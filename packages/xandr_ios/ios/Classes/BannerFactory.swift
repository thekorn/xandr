//
//  BannerFactory.swift
//  xandr_ios
//
//  Created by markus korn on 14.07.24.
//

import Flutter
import Foundation

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
    return state.getOrCreateXandrBanner(frame: frame, id: viewId, args: args)
  }

  func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
    FlutterStandardMessageCodec.sharedInstance()
  }
}
