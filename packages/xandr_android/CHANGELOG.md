## 0.2.17+1

 - Bump "xandr_android" to `0.2.17+1`.

## 0.2.17

 - **FIX**: defunct state on ad disposal (fixes #225).
 - **FIX**: Correct 'customelements' typo in changelogs.

## 0.2.16

 - **FEAT**: return customElements in native ad response (fixes 227) (#228).

## 0.2.15+1

 - Bump "xandr_android" to `0.2.15+1`.

## 0.2.15

 - **FEAT**: add optional nativeAdRendererId to add requests (#218) (#222).
 - **FEAT**: Update packages and dependencies (#219).

## 0.2.14

 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.7.3.

## 0.2.13

 - **FIX**(deps): update dependency com.appnexus.opensdk:appnexus-sdk to v9.2.0.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.7.2.

## 0.2.12

 - Bump "xandr_android" to `0.2.12`.

## 0.2.11

 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.7.0.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.6.0.
 - **FEAT**: add setAutoRefreshInterval method to xandr controller.

## 0.2.10

 - Bump "xandr_android" to `0.2.10`.

## 0.2.9

 - Bump "xandr_android" to `0.2.9`.

## 0.2.8

 - Fix StackOverflow error in XandrPlugin.kt Activity hooks (#141)

 - **FIX**: don't recursively call the onDetachFromActivity() in the android.
 - **FEAT**: Update dependencies and streamline naming.
 - **DOCS**: inline comment on the unimplemented hooks in XandrPlugin.kt.

## 0.2.7

 - Fix null check in kotlin land

 - **FIX**: null safe call on xandr native ad response.
 - **FEAT**: add test mode config param on init.

## 0.2.6

 - **FEAT**: clickUrl implementation on nativeAdLoaded event.

## 0.2.5+2

 - **FIX**: fix clickThroughAction ios implementation + onAdClicked callback.

## 0.2.5+1

 - **FIX**: _onDoneLoading callback not called on ios.

## 0.2.5

 - **REFACTOR**(xandr): add lazy loading support for banner ads.
 - **REFACTOR**(xandr_android): move BannerAd and InterstitialAd logic to separate classes for better code organization.
 - **REFACTOR**(xandr_android): simplify InterstitialAd instantiation and usage in XandrPlugin.kt.
 - **REFACTOR**(xandr_android): improve handling of custom keywords in BannerViewContainer.
 - **REFACTOR**(xandr_android): import new models and listeners to improve ad handling.
 - **REFACTOR**(xandr_android): remove unused imports and classes from BannerViewContainer.kt.
 - **REFACTOR**(xandr_android): make XandrAdListener class open for extension.
 - **REFACTOR**(xandr_android): improve code readability and formatting.
 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr): remove unused classes and improve error handling.
 - **REFACTOR**(xandr_android): simplify ad loaded event handling by passing parameters directly.
 - **REFACTOR**(xandr_android): replace eventSink with XandrFlutterApi for better event handling.
 - **REFACTOR**(xandr): move AdSize and AdBanner classes to separate files for better organization.
 - **REFACTOR**(xandr_android): split XandrPlugin.kt into separate classes for better code organization.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.5.0.
 - **FIX**(deps): update dependency com.appnexus.opensdk:appnexus-sdk to v9.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.4.1.
 - **FIX**: use `flutterApi.setup()` to setup the communication channel to the.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.4.0.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.2.
 - **FEAT**: Integrate optional publisherId across SDK init methods.
 - **FEAT**: new setup script for the environment.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **FEAT**(xandr_android,xandr_ios): implement XandrHostApi using Pigeon for interop.
 - **DOCS**: Add TODO comment to android implementation to refactor unnecessary flutterPluginBinding assignment.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.

## 0.2.4

 - **REFACTOR**(xandr): add lazy loading support for banner ads.
 - **REFACTOR**(xandr_android): move BannerAd and InterstitialAd logic to separate classes for better code organization.
 - **REFACTOR**(xandr_android): simplify InterstitialAd instantiation and usage in XandrPlugin.kt.
 - **REFACTOR**(xandr_android): improve handling of custom keywords in BannerViewContainer.
 - **REFACTOR**(xandr_android): import new models and listeners to improve ad handling.
 - **REFACTOR**(xandr_android): remove unused imports and classes from BannerViewContainer.kt.
 - **REFACTOR**(xandr_android): make XandrAdListener class open for extension.
 - **REFACTOR**(xandr_android): improve code readability and formatting.
 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr): remove unused classes and improve error handling.
 - **REFACTOR**(xandr_android): simplify ad loaded event handling by passing parameters directly.
 - **REFACTOR**(xandr_android): replace eventSink with XandrFlutterApi for better event handling.
 - **REFACTOR**(xandr): move AdSize and AdBanner classes to separate files for better organization.
 - **REFACTOR**(xandr_android): split XandrPlugin.kt into separate classes for better code organization.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.5.0.
 - **FIX**(deps): update dependency com.appnexus.opensdk:appnexus-sdk to v9.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.4.1.
 - **FIX**: use `flutterApi.setup()` to setup the communication channel to the.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.4.0.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.2.
 - **FEAT**: Integrate optional publisherId across SDK init methods.
 - **FEAT**: new setup script for the environment.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **FEAT**(xandr_android,xandr_ios): implement XandrHostApi using Pigeon for interop.
 - **DOCS**: Add TODO comment to android implementation to refactor unnecessary flutterPluginBinding assignment.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.

## 0.2.3+13

 - android: fix some imports in the kotlin code

## 0.2.3+12

## 0.2.3+11

 - Bump "xandr_android" to `0.2.3+11`.

## 0.2.3+10

 - Bump "xandr_android" to `0.2.3+10`.

## 0.2.3+9

 - Bump "xandr_android" to `0.2.3+9`.

## 0.2.3+8

 - Bump "xandr_android" to `0.2.3+8`.

## 0.2.3+7

 - Bump "xandr_android" to `0.2.3+7`.

## 0.2.3+6

 - Bump "xandr_android" to `0.2.3+6`.

## 0.2.3+5

 - Bump "xandr_android" to `0.2.3+5`.

## 0.2.3+4

## 0.2.3+3

 - Bump "xandr_android" to `0.2.3+3`.

## 0.2.3+2

 - Bump "xandr_android" to `0.2.3+2`.

## 0.2.3+1

## 0.2.3

## 0.2.2

 - Bump "xandr_android" to `0.2.2`.

## 0.2.1

 - Bump "xandr_android" to `0.2.1`.

## 0.2.0

 - Bump "xandr_android" to `0.2.0`.

## 0.1.7

 - Bump "xandr_android" to `0.1.7`.

## 0.1.6

 - Bump "xandr_android" to `0.1.6`.

## 0.1.5

 - Bump "xandr_android" to `0.1.5`.

## 0.1.4

 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.5.0.
 - **FIX**(deps): update dependency com.appnexus.opensdk:appnexus-sdk to v9.
 - **FEAT**: Integrate optional publisherId across SDK init methods.

## 0.1.3

 - Bump "xandr_android" to `0.1.3`.

## 0.1.2

 - Bump "xandr_android" to `0.1.2`.

## 0.1.1+3

 - Bump "xandr_android" to `0.1.1+3`.

## 0.1.1+2

 - pigeon: use a custom name for the generated flutter error class to not risk re-definition of the error class

## 0.1.1+1

 - Bump "xandr_android" to `0.1.1+1`.

## 0.1.1

 - Initial Beta Release

 - **REFACTOR**(xandr): add lazy loading support for banner ads.
 - **REFACTOR**(xandr_android): move BannerAd and InterstitialAd logic to separate classes for better code organization.
 - **REFACTOR**(xandr_android): simplify InterstitialAd instantiation and usage in XandrPlugin.kt.
 - **REFACTOR**(xandr_android): improve handling of custom keywords in BannerViewContainer.
 - **REFACTOR**(xandr_android): import new models and listeners to improve ad handling.
 - **REFACTOR**(xandr_android): remove unused imports and classes from BannerViewContainer.kt.
 - **REFACTOR**(xandr_android): make XandrAdListener class open for extension.
 - **REFACTOR**(xandr_android): improve code readability and formatting.
 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr): remove unused classes and improve error handling.
 - **REFACTOR**(xandr_android): simplify ad loaded event handling by passing parameters directly.
 - **REFACTOR**(xandr_android): replace eventSink with XandrFlutterApi for better event handling.
 - **REFACTOR**(xandr): move AdSize and AdBanner classes to separate files for better organization.
 - **REFACTOR**(xandr_android): split XandrPlugin.kt into separate classes for better code organization.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.4.1.
 - **FIX**: use `flutterApi.setup()` to setup the communication channel to the.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.4.0.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.2.
 - **FEAT**: new setup script for the environment.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **FEAT**(xandr_android,xandr_ios): implement XandrHostApi using Pigeon for interop.
 - **DOCS**: Add TODO comment to android implementation to refactor unnecessary flutterPluginBinding assignment.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.

# 0.1.0+1

- Initial release of this plugin.
