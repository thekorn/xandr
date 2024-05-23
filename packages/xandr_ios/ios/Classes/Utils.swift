public class Completer<T> {
  typealias CompletionHandler = (T) -> Void

  private var completionHandler: CompletionHandler?

  private var _isCompleted: Bool = false
  public var isCompleted: Bool { _isCompleted }

  private var _completedValue: T?

  func complete(_ result: T) {
    DispatchQueue.main.async {
      self.completionHandler?(result)
    }
    _isCompleted = true
    _completedValue = result
  }

  func invokeOnCompletion(_ handler: @escaping CompletionHandler) {
    if _isCompleted {
      return handler(_completedValue!)
    }
    completionHandler = handler
  }

  func getCompleted() -> T? {
    _completedValue
  }
}
