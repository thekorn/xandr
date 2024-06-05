# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.1`](#xandr---v011)
 - [`xandr_android` - `v0.1.1`](#xandr_android---v011)
 - [`xandr_ios` - `v0.1.1`](#xandr_ios---v011)
 - [`xandr_platform_interface` - `v0.1.1`](#xandr_platform_interface---v011)

---

#### `xandr` - `v0.1.1`

 - Initial Beta Release

 - **REFACTOR**(xandr): add lazy loading support for banner ads.
 - **REFACTOR**(xandr_ios): update minimum iOS version to 11.0 and add AppNexusSDK dependency.
 - **REFACTOR**(xandr_android): improve code readability and formatting.
 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr): remove unused classes and improve error handling.
 - **REFACTOR**(xandr): move AdSize and AdBanner classes to separate files for better organization.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.1.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.0.
 - **FIX**(deps): update kotlin monorepo to v1.9.23.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**(xandr): add support for interstitial ads.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.

#### `xandr_android` - `v0.1.1`

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

#### `xandr_ios` - `v0.1.1`

 - Initial Beta Release

 - **REFACTOR**(xandr_ios): update minimum iOS version to 11.0 and add AppNexusSDK dependency.
 - **FEAT**: new setup script for the environment.
 - **FEAT**(xandr_ios): add support for Xandr SDK initialization, interstitial ad loading and showing.
 - **FEAT**(xandr_android,xandr_ios): implement XandrHostApi using Pigeon for interop.

#### `xandr_platform_interface` - `v0.1.1`

 - Initial Beta Release

 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr_android): replace eventSink with XandrFlutterApi for better event handling.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**(xandr_ios): add support for Xandr SDK initialization, interstitial ad loading and showing.
 - **FEAT**(xandr): add support for interstitial ads.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **FEAT**(xandr_platform_interface): add new interface and method channel classes.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.

