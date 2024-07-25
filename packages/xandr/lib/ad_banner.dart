import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/load_mode.dart';
import 'package:xandr/xandr.dart';
import 'package:xandr_android/xandr_android.dart';

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
  })  : assert(adSizes.isNotEmpty, 'adSizes must not be empty'),
        assert(
          placementID != null || inventoryCode != null,
          'placementID or inventoryCode must not be null',
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

  /// Whether to allow native demand for the ad banner.
  final bool allowNativeDemand;

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

  final _DoneLoadingCallback? onBannerFinishLoading;

  /// A completer that indicates when loading is done.
  final Completer<bool> doneLoading = Completer();

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  double _width = 1;
  double _height = 1;
  bool _loading = false;
  bool _loaded = false;
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
    super.initState();
  }

  /// trigger ad loading via [MethodChannel]
  void loadAd() {
    if (!_loaded && !_loading) {
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
    setState(() {
      _width = width;
      _height = height;
    });
  }

  void onDoneLoading({required bool success, int? width, int? height}) {
    if (widget.onBannerFinishLoading != null) {
      widget.onBannerFinishLoading!(
        success: success,
        width: width,
        height: height,
      );
    }

    debugPrint('>>>> onDoneLoading: $success');
    setState(() {
      _loading = false;
      _loaded = success;
    });
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: waitIsInitialized(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return SizedBox(
              width: _width, //adSizes.first.width.toDouble(),
              height: _height, //adSizes.first.height.toDouble(),
              child: _HostAdBannerView(
                placementID: widget.placementID,
                inventoryCode: widget.inventoryCode,
                adSizes: widget.adSizes,
                customKeywords: widget.customKeywords ?? {},
                allowNativeDemand: widget.allowNativeDemand,
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
                delegate: BannerAdEventDelegate(
                  onBannerAdLoaded: (event) {
                    debugPrint('>>>> onBannerAdLoaded: $event');
                    onDoneLoading(
                        success: true,
                        width: event.width,
                        height: event.height);
                  },
                  onBannerAdLoadedError: (error) {
                    debugPrint('>>>> onBannerAdLoadedError: $error');
                    onDoneLoading(success: false);
                  },
                ),
              ),
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

typedef _DoneLoadingCallback = void Function(
    {required bool success, int? width, int? height});

class _HostAdBannerView extends StatelessWidget {
  _HostAdBannerView({
    required String? placementID,
    required String? inventoryCode,
    required List<AdSize> adSizes,
    required CustomKeywords customKeywords,
    required bool allowNativeDemand,
    required Duration autoRefreshInterval,
    required bool resizeWhenLoaded,
    required this.controller,
    required int layoutHeight,
    required int layoutWidth,
    required bool resizeAdToFitContainer,
    required LoadMode loadMode,
    required _DoneLoadingCallback onDoneLoading,
    required this.widgetId,
    required String? multiAdRequestId,
    ClickThroughAction? clickThroughAction,
    bool? loadsInBackground,
    bool? shouldServePSAs,
    bool? enableLazyLoad,
    this.delegate,
  })  : _onDoneLoading = onDoneLoading,
        creationParams = <String, dynamic>{
          'placementID': placementID,
          'inventoryCode': inventoryCode,
          'autoRefreshInterval': autoRefreshInterval.inMilliseconds,
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
  }

  static const StandardMessageCodec _decoder = StandardMessageCodec();
  final Map<String, dynamic> creationParams;
  final XandrController controller;
  final BannerAdEventDelegate? delegate;
  final _DoneLoadingCallback _onDoneLoading;
  final Completer<int> widgetId;

  static const viewType = 'de.thekorn.xandr/ad_banner';

  @override
  Widget build(BuildContext context) {
    assert(
      defaultTargetPlatform != TargetPlatform.android ||
          defaultTargetPlatform != TargetPlatform.iOS,
      'The AdBanner widget is not supported on $defaultTargetPlatform',
    );
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: viewType,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: creationParams,
        creationParamsCodec: _decoder,
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: viewType,
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: creationParams,
        creationParamsCodec: _decoder,
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
        delegate?.onBannerAdLoaded?.call(event);
      } else if (event is BannerAdLoadedErrorEvent) {
        _onDoneLoading(success: false);
        delegate?.onBannerAdLoadedError?.call(event);
      } else if (event is NativeBannerAdLoadedEvent) {
        _onDoneLoading(success: true);
        delegate?.onNativeBannerAdLoaded?.call(event);
      } else if (event is NativeBannerAdLoadedErrorEvent) {
        _onDoneLoading(success: false);
        delegate?.onNativeBannerAdLoadedError?.call(event);
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
