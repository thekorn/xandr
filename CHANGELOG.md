# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-07-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.4`](#xandr---v024)
 - [`xandr_android` - `v0.2.4`](#xandr_android---v024)
 - [`xandr_ios` - `v0.2.4`](#xandr_ios---v024)
 - [`xandr_platform_interface` - `v0.2.4`](#xandr_platform_interface---v024)

---

#### `xandr` - `v0.2.4`

 - **REFACTOR**(xandr): add lazy loading support for banner ads.
 - **REFACTOR**(xandr_ios): update minimum iOS version to 11.0 and add AppNexusSDK dependency.
 - **REFACTOR**(xandr_android): improve code readability and formatting.
 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr): remove unused classes and improve error handling.
 - **REFACTOR**(xandr): move AdSize and AdBanner classes to separate files for better organization.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.1.
 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.3.0.
 - **FIX**(deps): update kotlin monorepo to v1.9.23.
 - **FEAT**: Integrate optional publisherId across SDK init methods.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**(xandr): add support for interstitial ads.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.

#### `xandr_android` - `v0.2.4`

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

#### `xandr_ios` - `v0.2.4`

 - **REFACTOR**(xandr_ios): update minimum iOS version to 11.0 and add AppNexusSDK dependency.
 - **FIX**: ios on load handler and error handler.
 - **FEAT**: Integrate optional publisherId across SDK init methods.
 - **FEAT**: new setup script for the environment.
 - **FEAT**(xandr_ios): add support for Xandr SDK initialization, interstitial ad loading and showing.
 - **FEAT**(xandr_android,xandr_ios): implement XandrHostApi using Pigeon for interop.

#### `xandr_platform_interface` - `v0.2.4`

 - **REFACTOR**(xandr): change StreamController type from String to BannerAdEvent for better type safety.
 - **REFACTOR**(xandr_android): replace eventSink with XandrFlutterApi for better event handling.
 - **FEAT**: Integrate optional publisherId across SDK init methods.
 - **FEAT**: initial implementation of multi ad requests.
 - **FEAT**(xandr_ios): add support for Xandr SDK initialization, interstitial ad loading and showing.
 - **FEAT**(xandr): add support for interstitial ads.
 - **FEAT**: initial implementation of an event stream for banner ads.
 - **FEAT**(xandr_platform_interface): add new interface and method channel classes.
 - **DOCS**(xandr): add detailed comments to public classes and methods for better understanding.


## 2024-07-26

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+13`](#xandr---v02313)
 - [`xandr_android` - `v0.2.3+13`](#xandr_android---v02313)
 - [`xandr_ios` - `v0.2.3+13`](#xandr_ios---v02313)
 - [`xandr_platform_interface` - `v0.2.3+13`](#xandr_platform_interface---v02313)

---

#### `xandr` - `v0.2.3+13`

 - Bump "xandr" to `0.2.3+13`.

#### `xandr_android` - `v0.2.3+13`

 - android: fix some imports in the kotlin code

#### `xandr_ios` - `v0.2.3+13`

 - Bump "xandr_ios" to `0.2.3+13`.

#### `xandr_platform_interface` - `v0.2.3+13`

 - Bump "xandr_platform_interface" to `0.2.3+13`.


## 2024-07-26

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+12`](#xandr---v02312)
 - [`xandr_android` - `v0.2.3+12`](#xandr_android---v02312)
 - [`xandr_ios` - `v0.2.3+12`](#xandr_ios---v02312)
 - [`xandr_platform_interface` - `v0.2.3+12`](#xandr_platform_interface---v02312)

---

#### `xandr` - `v0.2.3+12`

 - Bump "xandr" to `0.2.3+12`.

#### `xandr_android` - `v0.2.3+12`

#### `xandr_ios` - `v0.2.3+12`

 - Bump "xandr_ios" to `0.2.3+12`.

#### `xandr_platform_interface` - `v0.2.3+12`

 - Bump "xandr_platform_interface" to `0.2.3+12`.


## 2024-07-26

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+11`](#xandr---v02311)
 - [`xandr_android` - `v0.2.3+11`](#xandr_android---v02311)
 - [`xandr_ios` - `v0.2.3+11`](#xandr_ios---v02311)
 - [`xandr_platform_interface` - `v0.2.3+11`](#xandr_platform_interface---v02311)

---

#### `xandr` - `v0.2.3+11`

 - Bump "xandr" to `0.2.3+11`.

#### `xandr_android` - `v0.2.3+11`

 - Bump "xandr_android" to `0.2.3+11`.

#### `xandr_ios` - `v0.2.3+11`

 - Bump "xandr_ios" to `0.2.3+11`.

#### `xandr_platform_interface` - `v0.2.3+11`

 - Bump "xandr_platform_interface" to `0.2.3+11`.


## 2024-07-26

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+10`](#xandr---v02310)
 - [`xandr_android` - `v0.2.3+10`](#xandr_android---v02310)
 - [`xandr_ios` - `v0.2.3+10`](#xandr_ios---v02310)
 - [`xandr_platform_interface` - `v0.2.3+10`](#xandr_platform_interface---v02310)

---

#### `xandr` - `v0.2.3+10`

 - Bump "xandr" to `0.2.3+10`.

#### `xandr_android` - `v0.2.3+10`

 - Bump "xandr_android" to `0.2.3+10`.

#### `xandr_ios` - `v0.2.3+10`

 - Bump "xandr_ios" to `0.2.3+10`.

#### `xandr_platform_interface` - `v0.2.3+10`

 - Bump "xandr_platform_interface" to `0.2.3+10`.


## 2024-07-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+9`](#xandr---v0239)
 - [`xandr_android` - `v0.2.3+9`](#xandr_android---v0239)
 - [`xandr_ios` - `v0.2.3+9`](#xandr_ios---v0239)
 - [`xandr_platform_interface` - `v0.2.3+9`](#xandr_platform_interface---v0239)

---

#### `xandr` - `v0.2.3+9`

 - Bump "xandr" to `0.2.3+9`.

#### `xandr_android` - `v0.2.3+9`

 - Bump "xandr_android" to `0.2.3+9`.

#### `xandr_ios` - `v0.2.3+9`

 - **FIX**: ios on load handler and error handler.

#### `xandr_platform_interface` - `v0.2.3+9`

 - Bump "xandr_platform_interface" to `0.2.3+9`.


## 2024-07-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+8`](#xandr---v0238)
 - [`xandr_android` - `v0.2.3+8`](#xandr_android---v0238)
 - [`xandr_ios` - `v0.2.3+8`](#xandr_ios---v0238)
 - [`xandr_platform_interface` - `v0.2.3+8`](#xandr_platform_interface---v0238)

---

#### `xandr` - `v0.2.3+8`

 - Bump "xandr" to `0.2.3+8`.

#### `xandr_android` - `v0.2.3+8`

 - Bump "xandr_android" to `0.2.3+8`.

#### `xandr_ios` - `v0.2.3+8`

 - Bump "xandr_ios" to `0.2.3+8`.

#### `xandr_platform_interface` - `v0.2.3+8`

 - Bump "xandr_platform_interface" to `0.2.3+8`.


## 2024-07-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+7`](#xandr---v0237)
 - [`xandr_android` - `v0.2.3+7`](#xandr_android---v0237)
 - [`xandr_ios` - `v0.2.3+7`](#xandr_ios---v0237)
 - [`xandr_platform_interface` - `v0.2.3+7`](#xandr_platform_interface---v0237)

---

#### `xandr` - `v0.2.3+7`

 - Bump "xandr" to `0.2.3+7`.

#### `xandr_android` - `v0.2.3+7`

 - Bump "xandr_android" to `0.2.3+7`.

#### `xandr_ios` - `v0.2.3+7`

 - implementation of the onAdRecieved signal

#### `xandr_platform_interface` - `v0.2.3+7`

 - Bump "xandr_platform_interface" to `0.2.3+7`.


## 2024-07-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+6`](#xandr---v0236)
 - [`xandr_android` - `v0.2.3+6`](#xandr_android---v0236)
 - [`xandr_ios` - `v0.2.3+6`](#xandr_ios---v0236)
 - [`xandr_platform_interface` - `v0.2.3+6`](#xandr_platform_interface---v0236)

---

#### `xandr` - `v0.2.3+6`

 - Bump "xandr" to `0.2.3+6`.

#### `xandr_android` - `v0.2.3+6`

 - Bump "xandr_android" to `0.2.3+6`.

#### `xandr_ios` - `v0.2.3+6`

 - Bump "xandr_ios" to `0.2.3+6`.

#### `xandr_platform_interface` - `v0.2.3+6`

 - Bump "xandr_platform_interface" to `0.2.3+6`.


## 2024-07-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+5`](#xandr---v0235)
 - [`xandr_android` - `v0.2.3+5`](#xandr_android---v0235)
 - [`xandr_ios` - `v0.2.3+5`](#xandr_ios---v0235)
 - [`xandr_platform_interface` - `v0.2.3+5`](#xandr_platform_interface---v0235)

---

#### `xandr` - `v0.2.3+5`

 - Bump "xandr" to `0.2.3+5`.

#### `xandr_android` - `v0.2.3+5`

 - Bump "xandr_android" to `0.2.3+5`.

#### `xandr_ios` - `v0.2.3+5`

 - Bump "xandr_ios" to `0.2.3+5`.

#### `xandr_platform_interface` - `v0.2.3+5`

 - Bump "xandr_platform_interface" to `0.2.3+5`.


## 2024-07-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+4`](#xandr---v0234)
 - [`xandr_android` - `v0.2.3+4`](#xandr_android---v0234)
 - [`xandr_ios` - `v0.2.3+4`](#xandr_ios---v0234)
 - [`xandr_platform_interface` - `v0.2.3+4`](#xandr_platform_interface---v0234)

---

#### `xandr` - `v0.2.3+4`

#### `xandr_android` - `v0.2.3+4`

#### `xandr_ios` - `v0.2.3+4`

 - Bump "xandr_ios" to `0.2.3+4`.

#### `xandr_platform_interface` - `v0.2.3+4`

 - Bump "xandr_platform_interface" to `0.2.3+4`.


## 2024-07-17

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+3`](#xandr---v0233)
 - [`xandr_android` - `v0.2.3+3`](#xandr_android---v0233)
 - [`xandr_ios` - `v0.2.3+3`](#xandr_ios---v0233)
 - [`xandr_platform_interface` - `v0.2.3+3`](#xandr_platform_interface---v0233)

---

#### `xandr` - `v0.2.3+3`

 - Fix #111 - Bad State in the scroll detector

#### `xandr_android` - `v0.2.3+3`

 - Bump "xandr_android" to `0.2.3+3`.

#### `xandr_ios` - `v0.2.3+3`

 - Bump "xandr_ios" to `0.2.3+3`.

#### `xandr_platform_interface` - `v0.2.3+3`

 - Bump "xandr_platform_interface" to `0.2.3+3`.


## 2024-07-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+2`](#xandr---v0232)
 - [`xandr_android` - `v0.2.3+2`](#xandr_android---v0232)
 - [`xandr_ios` - `v0.2.3+2`](#xandr_ios---v0232)
 - [`xandr_platform_interface` - `v0.2.3+2`](#xandr_platform_interface---v0232)

---

#### `xandr` - `v0.2.3+2`

 - Bump "xandr" to `0.2.3+2`.

#### `xandr_android` - `v0.2.3+2`

 - Bump "xandr_android" to `0.2.3+2`.

#### `xandr_ios` - `v0.2.3+2`

 - iOS interstitials: bind the interstitial to the parentmost view controller

#### `xandr_platform_interface` - `v0.2.3+2`

 - Bump "xandr_platform_interface" to `0.2.3+2`.


## 2024-07-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3+1`](#xandr---v0231)
 - [`xandr_android` - `v0.2.3+1`](#xandr_android---v0231)
 - [`xandr_ios` - `v0.2.3+1`](#xandr_ios---v0231)
 - [`xandr_platform_interface` - `v0.2.3+1`](#xandr_platform_interface---v0231)

---

#### `xandr` - `v0.2.3+1`

#### `xandr_android` - `v0.2.3+1`

#### `xandr_ios` - `v0.2.3+1`

 - dont use testMode anymore

#### `xandr_platform_interface` - `v0.2.3+1`


## 2024-07-14

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.3`](#xandr---v023)
 - [`xandr_android` - `v0.2.3`](#xandr_android---v023)
 - [`xandr_ios` - `v0.2.3`](#xandr_ios---v023)
 - [`xandr_platform_interface` - `v0.2.3`](#xandr_platform_interface---v023)

---

#### `xandr` - `v0.2.3`

#### `xandr_android` - `v0.2.3`

#### `xandr_ios` - `v0.2.3`

#### `xandr_platform_interface` - `v0.2.3`


## 2024-06-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.2`](#xandr---v022)
 - [`xandr_android` - `v0.2.2`](#xandr_android---v022)
 - [`xandr_ios` - `v0.2.2`](#xandr_ios---v022)
 - [`xandr_platform_interface` - `v0.2.2`](#xandr_platform_interface---v022)

---

#### `xandr` - `v0.2.2`

 - Bump "xandr" to `0.2.2`.

#### `xandr_android` - `v0.2.2`

 - Bump "xandr_android" to `0.2.2`.

#### `xandr_ios` - `v0.2.2`

 - Bump "xandr_ios" to `0.2.2`.

#### `xandr_platform_interface` - `v0.2.2`

 - Bump "xandr_platform_interface" to `0.2.2`.


## 2024-06-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.1`](#xandr---v021)
 - [`xandr_android` - `v0.2.1`](#xandr_android---v021)
 - [`xandr_ios` - `v0.2.1`](#xandr_ios---v021)
 - [`xandr_platform_interface` - `v0.2.1`](#xandr_platform_interface---v021)

---

#### `xandr` - `v0.2.1`

 - Bump "xandr" to `0.2.1`.

#### `xandr_android` - `v0.2.1`

 - Bump "xandr_android" to `0.2.1`.

#### `xandr_ios` - `v0.2.1`

 - Bump "xandr_ios" to `0.2.1`.

#### `xandr_platform_interface` - `v0.2.1`

 - Bump "xandr_platform_interface" to `0.2.1`.


## 2024-06-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.2.0`](#xandr---v020)
 - [`xandr_android` - `v0.2.0`](#xandr_android---v020)
 - [`xandr_ios` - `v0.2.0`](#xandr_ios---v020)
 - [`xandr_platform_interface` - `v0.2.0`](#xandr_platform_interface---v020)

---

#### `xandr` - `v0.2.0`

 - Bump "xandr" to `0.2.0`.

#### `xandr_android` - `v0.2.0`

 - Bump "xandr_android" to `0.2.0`.

#### `xandr_ios` - `v0.2.0`

 - Bump "xandr_ios" to `0.2.0`.

#### `xandr_platform_interface` - `v0.2.0`

 - Bump "xandr_platform_interface" to `0.2.0`.


## 2024-06-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.7`](#xandr---v017)
 - [`xandr_android` - `v0.1.7`](#xandr_android---v017)
 - [`xandr_ios` - `v0.1.7`](#xandr_ios---v017)
 - [`xandr_platform_interface` - `v0.1.7`](#xandr_platform_interface---v017)

---

#### `xandr` - `v0.1.7`

 - Bump "xandr" to `0.1.7`.

#### `xandr_android` - `v0.1.7`

 - Bump "xandr_android" to `0.1.7`.

#### `xandr_ios` - `v0.1.7`

 - Bump "xandr_ios" to `0.1.7`.

#### `xandr_platform_interface` - `v0.1.7`

 - Bump "xandr_platform_interface" to `0.1.7`.


## 2024-06-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.6`](#xandr---v016)
 - [`xandr_android` - `v0.1.6`](#xandr_android---v016)
 - [`xandr_ios` - `v0.1.6`](#xandr_ios---v016)
 - [`xandr_platform_interface` - `v0.1.6`](#xandr_platform_interface---v016)

---

#### `xandr` - `v0.1.6`

 - Bump "xandr" to `0.1.6`.

#### `xandr_android` - `v0.1.6`

 - Bump "xandr_android" to `0.1.6`.

#### `xandr_ios` - `v0.1.6`

 - Bump "xandr_ios" to `0.1.6`.

#### `xandr_platform_interface` - `v0.1.6`

 - Bump "xandr_platform_interface" to `0.1.6`.


## 2024-06-21

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.5`](#xandr---v015)
 - [`xandr_android` - `v0.1.5`](#xandr_android---v015)
 - [`xandr_ios` - `v0.1.5`](#xandr_ios---v015)
 - [`xandr_platform_interface` - `v0.1.5`](#xandr_platform_interface---v015)

---

#### `xandr` - `v0.1.5`

 - Bump "xandr" to `0.1.5`.

#### `xandr_android` - `v0.1.5`

 - Bump "xandr_android" to `0.1.5`.

#### `xandr_ios` - `v0.1.5`

 - Bump "xandr_ios" to `0.1.5`.

#### `xandr_platform_interface` - `v0.1.5`

 - Bump "xandr_platform_interface" to `0.1.5`.


## 2024-06-20

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.4`](#xandr---v014)
 - [`xandr_android` - `v0.1.4`](#xandr_android---v014)
 - [`xandr_ios` - `v0.1.4`](#xandr_ios---v014)
 - [`xandr_platform_interface` - `v0.1.4`](#xandr_platform_interface---v014)

---

#### `xandr` - `v0.1.4`

 - **FEAT**: Integrate optional publisherId across SDK init methods.

#### `xandr_android` - `v0.1.4`

 - **FIX**(deps): update dependency com.android.tools.build:gradle to v8.5.0.
 - **FIX**(deps): update dependency com.appnexus.opensdk:appnexus-sdk to v9.
 - **FEAT**: Integrate optional publisherId across SDK init methods.

#### `xandr_ios` - `v0.1.4`

 - **FEAT**: Integrate optional publisherId across SDK init methods.

#### `xandr_platform_interface` - `v0.1.4`

 - **FEAT**: Integrate optional publisherId across SDK init methods.


## 2024-06-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.3`](#xandr---v013)
 - [`xandr_android` - `v0.1.3`](#xandr_android---v013)
 - [`xandr_ios` - `v0.1.3`](#xandr_ios---v013)
 - [`xandr_platform_interface` - `v0.1.3`](#xandr_platform_interface---v013)

---

#### `xandr` - `v0.1.3`

 - Note: this is introducing a breaking change, customKeyword values are now a list of strings

#### `xandr_android` - `v0.1.3`

 - Bump "xandr_android" to `0.1.3`.

#### `xandr_ios` - `v0.1.3`

 - Bump "xandr_ios" to `0.1.3`.

#### `xandr_platform_interface` - `v0.1.3`

 - Bump "xandr_platform_interface" to `0.1.3`.


## 2024-06-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.2`](#xandr---v012)
 - [`xandr_android` - `v0.1.2`](#xandr_android---v012)
 - [`xandr_ios` - `v0.1.2`](#xandr_ios---v012)
 - [`xandr_platform_interface` - `v0.1.2`](#xandr_platform_interface---v012)

---

#### `xandr` - `v0.1.2`

 - Note: this is introducing a breaking change, customKeyword values are now a list of strings

#### `xandr_android` - `v0.1.2`

 - Bump "xandr_android" to `0.1.2`.

#### `xandr_ios` - `v0.1.2`

 - Bump "xandr_ios" to `0.1.2`.

#### `xandr_platform_interface` - `v0.1.2`

 - Bump "xandr_platform_interface" to `0.1.2`.


## 2024-06-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.1+3`](#xandr---v0113)
 - [`xandr_android` - `v0.1.1+3`](#xandr_android---v0113)
 - [`xandr_ios` - `v0.1.1+3`](#xandr_ios---v0113)
 - [`xandr_platform_interface` - `v0.1.1+3`](#xandr_platform_interface---v0113)

---

#### `xandr` - `v0.1.1+3`

 - Bump "xandr" to `0.1.1+3`.

#### `xandr_android` - `v0.1.1+3`

 - Bump "xandr_android" to `0.1.1+3`.

#### `xandr_ios` - `v0.1.1+3`

 - Bump "xandr_ios" to `0.1.1+3`.

#### `xandr_platform_interface` - `v0.1.1+3`

 - y


## 2024-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.1+2`](#xandr---v0112)
 - [`xandr_android` - `v0.1.1+2`](#xandr_android---v0112)
 - [`xandr_ios` - `v0.1.1+2`](#xandr_ios---v0112)
 - [`xandr_platform_interface` - `v0.1.1+2`](#xandr_platform_interface---v0112)

---

#### `xandr` - `v0.1.1+2`

 - Bump "xandr" to `0.1.1+2`.

#### `xandr_android` - `v0.1.1+2`

 - pigeon: use a custom name for the generated flutter error class to not risk re-definition of the error class

#### `xandr_ios` - `v0.1.1+2`

 - Bump "xandr_ios" to `0.1.1+2`.

#### `xandr_platform_interface` - `v0.1.1+2`

 - Bump "xandr_platform_interface" to `0.1.1+2`.


## 2024-06-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`xandr` - `v0.1.1+1`](#xandr---v0111)
 - [`xandr_android` - `v0.1.1+1`](#xandr_android---v0111)
 - [`xandr_ios` - `v0.1.1+1`](#xandr_ios---v0111)
 - [`xandr_platform_interface` - `v0.1.1+1`](#xandr_platform_interface---v0111)

---

#### `xandr` - `v0.1.1+1`

 - Bump "xandr" to `0.1.1+1`.

#### `xandr_android` - `v0.1.1+1`

 - Bump "xandr_android" to `0.1.1+1`.

#### `xandr_ios` - `v0.1.1+1`

 - Bump "xandr_ios" to `0.1.1+1`.

#### `xandr_platform_interface` - `v0.1.1+1`

 - Bump "xandr_platform_interface" to `0.1.1+1`.


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

