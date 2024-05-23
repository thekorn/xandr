import AppNexusSDK
import Foundation

public class MultiAdRequestRegistry {
  private var multiAdRequests: [String: ANMultiAdRequest] = [:]

  private func generateRandomStringId() -> String {
    let length = 16
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0 ..< length).map { _ in letters.randomElement()! })
  }

  public func initNewRequest(_ mar: ANMultiAdRequest) -> String {
    let id = generateRandomStringId()
    multiAdRequests[id] = mar
    return id
  }

  public func removeRequestWithId(_ requestId: String) -> Bool {
    let mar = multiAdRequests[requestId]
    mar?.stop()
    multiAdRequests[requestId] = nil
    return mar != nil
  }

  public func load(_ requestId: String) -> Bool {
    let mar = multiAdRequests[requestId]
    return mar?.load() ?? false
  }

//  public func addAdUnit(requestId: String, ad: AdUnits) -> Bool {
//    let mar = multiAdRequests[requestId]
//    return mar?.addAdUnit(ad) ?? false
//  }
}
