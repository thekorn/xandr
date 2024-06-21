# Contributing to the project

## requirements

Packages:

- dart
- flutter
- swiftformat
- ktlint

```bash
dart pub global activate melos
dart pub global activate very_good_cli
```

## important commands

```bash
# bootstrap the project, install dependencies, and link packages
melos bootstrap

# generate platform code
melos run generate:pigeon

# generate test mocks
melos run generate:mocks

# run tests
melos run test

# run sample app
melos run run:example -- -d sdk     # android
melos run run:example -- -d IPhone  # ios

# setup a clean local environment
./setup_environment.sh
```

## working on the ios platform plugin in xcode

when working on the ios platform implementation you have to make sure to run `melos run run:example -- -d IPhone` at least once initially.
This will install, build and link all depending pods.
Once the build phase is done, open xcode and open the `xcworkspace` file in the `packages/xandr/example/ios/Runner.xcworkspace` directory - this
is opening the project in the right scope.
Now use the code navigation within xcode to navigate all the levels of symlinks in the development pods section.

![](./doc/images/xcode.gif)

## resources

### xandr

- [xandr ios SDK](https://github.com/appnexus/mobile-sdk-ios)
- [xandr android SDK](https://github.com/appnexus/mobile-sdk-android)
- [deprecated appnexus flutter integration](https://github.com/schibsted/appnexus-flutter)

### tooling

- [Flutter](https://flutter.dev/)
- [Flutter documentation](https://flutter.dev/docs)
- [using melos and very_good_cli](https://adityadroid.medium.com/flutter-at-scale-code-sharing-using-a-monorepo-a7a46c427141)
- [very good dev](https://vgv.dev)
- [melos](https://melos.invertase.dev)
- [example melos + pigeon repo: flutterfire](https://github.com/firebase/flutterfire/)
- [example pigeon + swift host and flutter api](https://gitlab.com/twilio-flutter/conversations/-/blob/master/ios/Classes/SwiftTwilioConversationsPlugin.swift)
