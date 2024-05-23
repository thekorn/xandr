import AppNexusSDK
import Foundation

public class InterstitialAd: ANInterstitialAd {
  public var isLoaded: Completer<Bool> = .init()
  public var isClosed: Completer<Bool> = .init()
}
