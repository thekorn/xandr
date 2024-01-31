import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xandr/ad_size.dart';
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
    this.allowNativeDemand = false,
    double? width,
    double? height,
  })  : assert(adSizes.isNotEmpty, 'adSizes must not be empty'),
        assert(
          placementID != null || inventoryCode != null,
          'placementID or inventoryCode must not be null',
        ),
        width = width ?? adSizes.first.width.toDouble(),
        height = height ?? adSizes.first.height.toDouble();

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

  /// The interval at which the ad banner should automatically refresh.
  final Duration autoRefreshInterval;

  /// Whether to allow native demand for the ad banner.
  final bool allowNativeDemand;

  /// The width of the ad banner.
  final double width;

  /// The height of the ad banner.
  final double height;

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  double _width = 1;
  double _height = 1;

  @override
  void initState() {
    super.initState();
    _height = widget.height;
    _width = widget.width;
  }

  void changeSize(double width, double height) {
    setState(() {
      _width = width;
      _height = height;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        controller: widget.controller,
        delegate: BannerAdEventDelegate(
          onBannerAdLoaded: (event) {
            debugPrint('>>>> onBannerAdLoaded: $event');
            changeSize(event.width.toDouble(), event.height.toDouble());
          },
        ),
      ),
    );
  }
}

class _HostAdBannerView extends StatelessWidget {
  _HostAdBannerView({
    required String? placementID,
    required String? inventoryCode,
    required List<AdSize> adSizes,
    required CustomKeywords customKeywords,
    required bool allowNativeDemand,
    required Duration autoRefreshInterval,
    required this.controller,
    this.delegate,
  }) : creationParams = <String, dynamic>{
          'placementID': placementID,
          'inventoryCode': inventoryCode,
          'autoRefreshInterval': autoRefreshInterval.inMilliseconds,
          'adSizes': adSizes.map((e) => e.toJson()).toList(),
          'customKeywords': customKeywords,
          'allowNativeDemand': allowNativeDemand,
        };
  static const StandardMessageCodec _decoder = StandardMessageCodec();
  final Map<String, dynamic> creationParams;
  final XandrController controller;
  final BannerAdEventDelegate? delegate;

  @override
  Widget build(BuildContext context) {
    // FIXME(thekorn): use proper host platform implementation
    return AndroidView(
      viewType: 'de.thekorn.xandr/ad_banner',
      onPlatformViewCreated: (id) {
        debugPrint('Created banner view: $id');
        controller.listen(id, (event) {
          if (event is BannerAdLoadedEvent) {
            delegate?.onBannerAdLoaded?.call(event);
          } else if (event is BannerAdLoadedErrorEvent) {
            delegate?.onBannerAdLoadedError?.call(event);
          } else if (event is NativeBannerAdLoadedEvent) {
            delegate?.onNativeBannerAdLoaded?.call(event);
          } else if (event is NativeBannerAdLoadedErrorEvent) {
            delegate?.onNativeBannerAdLoadedError?.call(event);
          }
        });
      },
      creationParams: creationParams,
      creationParamsCodec: _decoder,
    );
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
