// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/xandr.dart';

class AdBanner extends StatelessWidget {
  AdBanner({
    required this.placementID,
    required this.adSizes,
    required this.controller,
    super.key,
    this.customKeywords,
    this.autoRefreshInterval = const Duration(seconds: 30),
    this.allowNativeDemand = false,
  }) : assert(adSizes.isNotEmpty, 'adSizes must not be empty');
  final String placementID;
  final List<AdSize> adSizes;
  final CustomKeywords? customKeywords;
  final XandrController controller;
  final Duration autoRefreshInterval;
  final bool allowNativeDemand;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: adSizes.first.width.toDouble(),
      height: adSizes.first.height.toDouble(),
      child: _HostAdBannerView(
        placementID: placementID,
        adSizes: adSizes,
        customKeywords: customKeywords ?? {},
        allowNativeDemand: allowNativeDemand,
        autoRefreshInterval: autoRefreshInterval,
      ),
    );
  }
}

class _HostAdBannerView extends StatelessWidget {
  _HostAdBannerView({
    required String placementID,
    required List<AdSize> adSizes,
    required CustomKeywords customKeywords,
    required bool allowNativeDemand,
    required Duration autoRefreshInterval,
  }) : creationParams = <String, dynamic>{
          'inventoryCode': placementID,
          'autoRefreshInterval': autoRefreshInterval.inMilliseconds,
          'adSizes': adSizes.map((e) => e.toJson()).toList(),
          'customKeywords': customKeywords,
          'allowNativeDemand': allowNativeDemand,
        };
  static const StandardMessageCodec _decoder = StandardMessageCodec();
  final Map<String, dynamic> creationParams;

  @override
  Widget build(BuildContext context) {
    // FIXME(thekorn): use proper host platform implementation
    return AndroidView(
      viewType: 'de.thekorn.xandr/ad_banner',
      onPlatformViewCreated: (id) => debugPrint('Created banner view: $id'),
      creationParams: creationParams,
      creationParamsCodec: _decoder,
    );
  }
}
