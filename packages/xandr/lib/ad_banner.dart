import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/load_mode.dart';
import 'package:xandr/xandr.dart';

/// A widget that displays an banner advertisement.
class AdBanner extends StatefulWidget {
  /// Represents an ad banner widget.
  ///
  /// This widget is used to display an advertisement banner.
  /// It can be customized with various properties to control the appearance
  /// and behavior of the ad.
  AdBanner({
    required this.adSizes,
    required this.controller,
    this.placementID,
    this.inventoryCode,
    super.key,
    this.customKeywords,
    this.autoRefreshInterval = const Duration(seconds: 30),
    this.resizeWhenLoaded = false,
    this.allowNativeDemand = false,
    this.nativeAdRendererId,
    this.nativeAdBuilder,
    this.clickThroughAction,
    this.resizeAdToFitContainer = false,
    this.loadsInBackground,
    this.shouldServePSAs,
    this.enableLazyLoad,
    this.multiAdRequestController,
    LoadMode? loadMode,
    double? width,
    double? height,
    this.onBannerFinishLoading,
    this.onAdClicked,
  }) : assert(adSizes.isNotEmpty, 'adSizes must not be empty'),
       assert(
         placementID != null || inventoryCode != null,
         'placementID or inventoryCode must not be null',
       ),
       assert(
         (allowNativeDemand == false && nativeAdBuilder == null) ||
             (allowNativeDemand == true && nativeAdBuilder != null),
         'nativeAdBuilder must be set if allowNativeDemand is true',
       ),
       assert(
         (nativeAdRendererId != null && allowNativeDemand == true) ||
             nativeAdRendererId == null,
         'allowNativeDemand must be true if nativeAdRendererId is set',
       ),
       //Note: opensdk:auto_refresh_interval or
       // adview.setAutoRefreshInterval(long interval): The interval, in
       // milliseconds, at which the ad view will request new ads, if
       // autorefresh is enabled. The minimum period is 15 seconds. The default
       // period is 30 seconds. Set this to 0 to disable autorefresh.
       //Note: while the docs says its in milliseconds, seconds seems to be the
       // right unit.
       // see: https://learn.microsoft.com/en-us/xandr/mobile-sdk/show-banners-on-android
       assert(
         autoRefreshInterval.inSeconds == 0 ||
             autoRefreshInterval.inSeconds >= 15,
         'autoRefreshInterval must be either 0 seconds or >= 15 seconds',
       ),
       width = width ?? adSizes.first.width.toDouble(),
       height = height ?? adSizes.first.height.toDouble(),
       loadMode = loadMode ?? LoadMode.whenCreated();

  /// The placement ID for the ad banner.
  final String? placementID;

  /// The inventory code for the ad banner.
  final String? inventoryCode;

  /// Represents a banner ad with multiple sizes.
  ///
  /// The [AdBanner] class is used to display banner ads in different sizes.
  /// The [adSizes] property is a list of [AdSize] objects that represent the
  /// available sizes for the banner ad.
  final List<AdSize> adSizes;

  /// The custom keywords for the ad banner.
  final CustomKeywords? customKeywords;

  /// The Xandr ad banner controller.
  /// Use this controller to interact with the Xandr ad banner.
  final XandrController controller;

  /// Whether the banner should be resized when it is loaded.
  final bool resizeWhenLoaded;

  /// The interval at which the ad banner should automatically refresh.
  final Duration autoRefreshInterval;

  /// If you want allow native ads - provide Widget builder for them
  final Widget Function(NativeAdData nativeAd)? nativeAdBuilder;

  /// Whether to allow native ads to be served
  final bool allowNativeDemand;

  /// The ID of the native ad renderer.
  ///
  /// This is an optional field that can be used to specify a custom renderer
  /// for native ads. If not provided, the default renderer will be used.
  final int? nativeAdRendererId;

  /// The width of the ad banner.
  final double width;

  /// The height of the ad banner.
  final double height;

  /// The action to perform when the ad banner is clicked.
  final ClickThroughAction? clickThroughAction;

  /// Whether the ad should be resized to fit its container.
  final bool resizeAdToFitContainer;

  /// The flag indicating whether the ad banner loads in the background.
  final bool? loadsInBackground;

  /// Determines whether PSAs (Public Service Announcements) should be served.
  /// PSAs (Public Service Announcements) are ads that can be served as a
  /// last resort, if there are no other ads to show.
  ///
  /// They are not enabled by default.
  final bool? shouldServePSAs;

  /// The flag indicating whether lazy loading is enabled for the ad banner.
  /// lazy loading banner ads is a performance optimization that defers the
  /// creation of the internal ad view until the ad is actually loaded.
  final bool? enableLazyLoad;

  /// The load mode for the ad banner, determines when the ad is loaded.
  final LoadMode loadMode;

  /// The controller for managing multi ad requests.
  final MultiAdRequestController? multiAdRequestController;

  /// Callback called when the ad finishes loading
  /// whether it's success or failure
  /// This also provides, if success, width and height of the ad
  final DoneLoadingCallback? onBannerFinishLoading;

  /// A completer that indicates when loading is done.
  final Completer<bool> doneLoading = Completer();

  /// A callback that is called when the banner is clicked
  final AdClickedCallback? onAdClicked;

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  double _width = 1;
  double _height = 1;
  bool _loading = false;
  bool _loaded = false;
  NativeAdData? _nativeAd;
  final Completer<int> _widgetId = Completer();

  @override
  void initState() {
    context.toString();
    if (widget.loadMode is LoadWhenCreated) {
      _loading = true;
    } else if (widget.loadMode is WhenInViewport) {
      (widget.loadMode as WhenInViewport).checkIfInViewport.listen((_) {
        _checkViewport((widget.loadMode as WhenInViewport).pixelOffset);
      });
    }
    _height = widget.height;
    _width = widget.width;
    super.initState();
  }

  /// trigger ad loading via [MethodChannel]
  void loadAd() {
    if (mounted && !_loaded && !_loading) {
      setState(() {
        _loading = true;
      });
      _widgetId.future.then((value) => widget.controller.loadAd(value));
    }
  }

  /// function used only with the [WhenInViewport] loadMode
  void _checkViewport(int pixelOffset) {
    if (!mounted || !context.mounted) return;
    final object = context.findRenderObject();

    if (object == null || !object.attached) {
      return;
    }

    final viewport = RenderAbstractViewport.of(object);
    final vpHeight = viewport.paintBounds.height;
    final vpOffset = viewport.getOffsetToReveal(object, 0);

    final deltaTop = vpOffset.offset - Scrollable.of(context).position.pixels;

    if ((vpHeight - deltaTop) > pixelOffset) {
      if (!_loading) {
        loadAd();
      }
    }
  }

  void changeSize(double width, double height) {
    debugPrint('>>>> changeSize: $width x $height');
    if (mounted) {
      setState(() {
        _width = width;
        _height = height;
      });
    }
  }

  void onDoneLoading({
    required bool success,
    int? width,
    int? height,
    NativeAdData? nativeAd,
  }) {
    widget.onBannerFinishLoading?.call(
      success: success,
      width: width,
      height: height,
    );

    debugPrint('>>>> onDoneLoading: $success');
    if (mounted) {
      setState(() {
        _loading = false;
        _loaded = success;
        _nativeAd = nativeAd;
      });
    }
    if (!widget.doneLoading.isCompleted) {
      widget.doneLoading.complete(success);
    }

    if (success && width != null && height != null) {
      changeSize(width.toDouble(), height.toDouble());
    }
  }

  Future<bool> waitIsInitialized() async {
    final xandrIsInitialized = await widget.controller.isInitialized.future;
    if (!xandrIsInitialized) return false;
    if (widget.multiAdRequestController == null) return xandrIsInitialized;
    final multiAdrequestInitialized =
        await widget.multiAdRequestController!.isInitialized.future;
    return multiAdrequestInitialized;
  }

  Widget? nativeAdWidget() =>
      _nativeAd != null && widget.nativeAdBuilder != null
      ? widget.nativeAdBuilder!(_nativeAd!)
      : null;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: waitIsInitialized(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return _HostAdBannerView(
              placementID: widget.placementID,
              inventoryCode: widget.inventoryCode,
              adSizes: widget.adSizes,
              customKeywords: widget.customKeywords ?? {},
              autoRefreshInterval: widget.autoRefreshInterval,
              resizeWhenLoaded: widget.resizeWhenLoaded,
              controller: widget.controller,
              layoutHeight: _height.toInt(),
              layoutWidth: _width.toInt(),
              clickThroughAction: widget.clickThroughAction,
              resizeAdToFitContainer: widget.resizeAdToFitContainer,
              loadsInBackground: widget.loadsInBackground,
              shouldServePSAs: widget.shouldServePSAs,
              loadMode: widget.loadMode,
              onDoneLoading: onDoneLoading,
              widgetId: _widgetId,
              enableLazyLoad: widget.enableLazyLoad,
              multiAdRequestId: widget.multiAdRequestController?.requestId,
              onAdClicked: widget.onAdClicked,
              allowNativeDemand: widget.allowNativeDemand,
              nativeAdRendererId: widget.nativeAdRendererId,
              nativeAdWidget: nativeAdWidget(),
            );
          } else {
            return const Text('Error initializing Xandr, error: false');
          }
        } else if (snapshot.hasError) {
          if (!widget.doneLoading.isCompleted) {
            widget.doneLoading.completeError(snapshot.error!);
          }
          return const Text('unknown Error initializing Xandr');
        } else {
          return SizedBox(
            width: _width, //adSizes.first.width.toDouble(),
            height: _height, //adSizes.first.height.toDouble(),
          );
        }
      },
    );
  }
}

/// Enum representing the possible actions when a user clicks on the ad banner.
enum ClickThroughAction {
  /// return the plain url.
  returnUrl,

  /// open the url in the in-app browser.
  openSdkBrowser,

  /// open the url in the device's default browser.
  openDeviceBrowser;

  @override
  String toString() {
    switch (this) {
      case ClickThroughAction.returnUrl:
        return 'return_url';
      case ClickThroughAction.openSdkBrowser:
        return 'open_sdk_browser';
      case ClickThroughAction.openDeviceBrowser:
        return 'open_device_browser';
    }
  }
}

/// Encapsulated data needed to render the native ad
class NativeAdData {
  /// Encapsulated data needed to render the native ad
  NativeAdData({
    required this.viewId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.clickUrl,
    required this.customElements,
  });

  /// native ad viewId
  final int viewId;

  /// native ad title
  final String title;

  /// native ad description
  final String description;

  /// native ad imageUrl
  final String imageUrl;

  /// native ad clickUrl
  final String clickUrl;

  /// A map containing custom elements for the ad banner.
  final Map<String, dynamic> customElements;
}

/// Represents a callback which is called when an ad is either loaded or
/// throws an error
typedef DoneLoadingCallback =
    void Function({
      required bool success,
      int? width,
      int? height,
      NativeAdData? nativeAd,
    });

/// Represents a callback which is called when an ad is clicked
typedef AdClickedCallback = void Function(String url);

class _HostAdBannerView extends StatelessWidget {
  _HostAdBannerView({
    required String? placementID,
    required String? inventoryCode,
    required List<AdSize> adSizes,
    required CustomKeywords customKeywords,
    required bool allowNativeDemand,
    required int? nativeAdRendererId,
    required Duration autoRefreshInterval,
    required bool resizeWhenLoaded,
    required this.controller,
    required this.layoutHeight,
    required this.layoutWidth,
    required bool resizeAdToFitContainer,
    required LoadMode loadMode,
    required DoneLoadingCallback onDoneLoading,
    required this.widgetId,
    required String? multiAdRequestId,
    ClickThroughAction? clickThroughAction,
    bool? loadsInBackground,
    bool? shouldServePSAs,
    bool? enableLazyLoad,
    this.onAdClicked,
    this.nativeAdWidget,
  }) : _onDoneLoading = onDoneLoading,
       creationParams = <String, dynamic>{
         'placementID': placementID,
         'inventoryCode': inventoryCode,
         'autoRefreshInterval': autoRefreshInterval.inSeconds,
         'adSizes': adSizes.map((e) => e.toJson()).toList(),
         'customKeywords': customKeywords,
         'allowNativeDemand': allowNativeDemand,
         'resizeWhenLoaded': resizeWhenLoaded,
         'layoutHeight': layoutHeight,
         'layoutWidth': layoutWidth,
         'resizeAdToFitContainer': resizeAdToFitContainer,
         'loadWhenCreated': loadMode is LoadWhenCreated,
       } {
    if (clickThroughAction != null) {
      creationParams['clickThroughAction'] = clickThroughAction.toString();
    }
    if (loadsInBackground != null) {
      creationParams['loadsInBackground'] = loadsInBackground;
    }
    if (shouldServePSAs != null) {
      creationParams['shouldServePSAs'] = shouldServePSAs;
    }
    if (enableLazyLoad != null) {
      creationParams['enableLazyLoad'] = enableLazyLoad;
    }
    if (multiAdRequestId != null) {
      creationParams['multiAdRequestId'] = multiAdRequestId;
    }
    if (nativeAdRendererId != null) {
      creationParams['nativeAdRendererId'] = nativeAdRendererId;
    }
  }

  static const StandardMessageCodec _decoder = StandardMessageCodec();
  final Map<String, dynamic> creationParams;
  final XandrController controller;
  final DoneLoadingCallback _onDoneLoading;
  final Completer<int> widgetId;
  final AdClickedCallback? onAdClicked;
  final Widget? nativeAdWidget;
  final int layoutWidth;
  final int layoutHeight;

  static const viewType = 'de.thekorn.xandr/ad_banner';

  @override
  Widget build(BuildContext context) {
    assert(
      defaultTargetPlatform != TargetPlatform.android ||
          defaultTargetPlatform != TargetPlatform.iOS,
      'The AdBanner widget is not supported on $defaultTargetPlatform',
    );
    debugPrint('>>>> _HostAdBannerView: build widgetId: ');
    if (nativeAdWidget != null) {
      return nativeAdWidget!;
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        width: layoutWidth.toDouble(),
        height: layoutHeight.toDouble(),
        child: AndroidView(
          viewType: viewType,
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams: creationParams,
          creationParamsCodec: _decoder,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        width: layoutWidth.toDouble(),
        height: layoutHeight.toDouble(),
        child: UiKitView(
          viewType: viewType,
          onPlatformViewCreated: onPlatformViewCreated,
          creationParams: creationParams,
          creationParamsCodec: _decoder,
        ),
      );
    } else {
      throw UnsupportedError(
        'The AdBanner widget is not supported on $defaultTargetPlatform',
      );
    }
  }

  void onPlatformViewCreated(int id) {
    debugPrint('Created banner view: $id');
    if (!widgetId.isCompleted) {
      widgetId.complete(id);
    }
    controller.listen(id, (event) {
      debugPrint('>>>> controller listen: $event');
      if (event is BannerAdLoadedEvent) {
        _onDoneLoading(success: true, width: event.width, height: event.height);
      } else if (event is BannerAdLoadedErrorEvent) {
        _onDoneLoading(success: false);
      } else if (event is NativeBannerAdLoadedEvent) {
        _onDoneLoading(
          success: true,
          nativeAd: NativeAdData(
            viewId: event.viewId,
            title: event.title,
            description: event.description,
            imageUrl: event.imageUrl,
            clickUrl: event.clickUrl,
            customElements: event.customElements,
          ),
        );
      } else if (event is NativeBannerAdLoadedErrorEvent) {
        _onDoneLoading(success: false);
      } else if (event is BannerAdClickedEvent) {
        onAdClicked?.call(event.url);
      }
    });
  }
}

/// A delegate for handling events related to banner ads.
class BannerAdEventDelegate {
  /// A delegate for handling events related to a banner ad.
  ///
  /// This delegate provides callbacks for various events that can occur
  /// during the lifecycle of a banner ad, such as when the ad is loaded,
  /// when an error occurs, or when the ad is clicked.
  BannerAdEventDelegate({
    this.onBannerAdLoaded,
    this.onBannerAdLoadedError,
    this.onNativeBannerAdLoaded,
    this.onNativeBannerAdLoadedError,
  });

  /// A callback function that is called when a banner ad is loaded.
  ///
  /// The [onBannerAdLoaded] function takes a [BannerAdLoadedEvent] as a
  /// parameter,
  /// which provides information about the loaded banner ad.
  /// If the [onBannerAdLoaded] function is not provided, no action will be
  /// taken when a banner ad is loaded.
  final void Function(BannerAdLoadedEvent)? onBannerAdLoaded;

  /// Callback function that is called when a banner ad fails to load.
  ///
  /// The [onBannerAdLoadedError] function is a callback that is triggered
  /// when a banner ad fails to load.
  /// It takes an optional parameter of type [BannerAdLoadedErrorEvent],
  /// which provides information about the error.
  /// If the banner ad loads successfully, this function will not be called.
  final void Function(BannerAdLoadedErrorEvent)? onBannerAdLoadedError;

  /// Callback function that is called when a native banner ad is loaded.
  ///
  /// The [onNativeBannerAdLoaded] function takes a [NativeBannerAdLoadedEvent]
  /// as a parameter.
  /// This event contains information about the loaded native banner ad.
  final void Function(NativeBannerAdLoadedEvent)? onNativeBannerAdLoaded;

  /// Callback function that is called when there is an error loading a native
  /// banner ad.
  final void Function(NativeBannerAdLoadedErrorEvent)?
  onNativeBannerAdLoadedError;
}
