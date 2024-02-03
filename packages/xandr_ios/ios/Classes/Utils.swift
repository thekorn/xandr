class Completer<T> {
  typealias CompletionHandler = (T) -> Void

  private var completionHandler: CompletionHandler?

  func complete(result: T) {
    DispatchQueue.main.async {
      self.completionHandler?(result)
    }
  }

  func setCompletionHandler(_ handler: @escaping CompletionHandler) {
    completionHandler = handler
  }
}