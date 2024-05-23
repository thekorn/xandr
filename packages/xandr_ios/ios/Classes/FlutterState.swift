//
//  FlutterState.swift
//  xandr_ios
//
//  Created by markus korn on 13.05.24.
//

import Flutter
import Foundation

public class FlutterState {
  public var isInitialized: Completer<Bool> = .init()
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
    isInitialized.complete(success)
  }

  public func setIsInitializedCompletionHandler(handler: @escaping (Bool) -> Void) {
    isInitialized.invokeOnCompletion(handler)
  }
}
