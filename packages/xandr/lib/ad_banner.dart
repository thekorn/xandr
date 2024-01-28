// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/xandr.dart';
import 'package:xandr_android/xandr_android.dart';

class AdBanner extends StatefulWidget {
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
  final String? placementID;
  final String? inventoryCode;
  final List<AdSize> adSizes;
  final CustomKeywords? customKeywords;
  final XandrController controller;
  final Duration autoRefreshInterval;
  final bool allowNativeDemand;
  final double width;
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

class BannerAdEventDelegate {
  BannerAdEventDelegate({
    this.onBannerAdLoaded,
    this.onBannerAdLoadedError,
    this.onNativeBannerAdLoaded,
    this.onNativeBannerAdLoadedError,
  });

  final void Function(BannerAdLoadedEvent)? onBannerAdLoaded;
  final void Function(BannerAdLoadedErrorEvent)? onBannerAdLoadedError;
  final void Function(NativeBannerAdLoadedEvent)? onNativeBannerAdLoaded;
  final void Function(NativeBannerAdLoadedErrorEvent)?
      onNativeBannerAdLoadedError;
}
