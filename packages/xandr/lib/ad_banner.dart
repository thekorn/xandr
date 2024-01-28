// ignore_for_file: public_member_api_docs

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/xandr.dart';

class AdBanner extends StatelessWidget {
  AdBanner({
    required this.adSizes,
    required this.controller,
    this.placementID,
    this.inventoryCode,
    super.key,
    this.customKeywords,
    this.autoRefreshInterval = const Duration(seconds: 30),
    this.allowNativeDemand = false,
  })  : assert(adSizes.isNotEmpty, 'adSizes must not be empty'),
        assert(
          placementID != null || inventoryCode != null,
          'placementID or inventoryCode must not be null',
        );
  final String? placementID;
  final String? inventoryCode;
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
        inventoryCode: inventoryCode,
        adSizes: adSizes,
        customKeywords: customKeywords ?? {},
        allowNativeDemand: allowNativeDemand,
        autoRefreshInterval: autoRefreshInterval,
        controller: controller,
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

  @override
  Widget build(BuildContext context) {
    // FIXME(thekorn): use proper host platform implementation
    return AndroidView(
      viewType: 'de.thekorn.xandr/ad_banner',
      onPlatformViewCreated: (id) {
        debugPrint('Created banner view: $id');
        controller.listen(id, (event) {
          debugPrint('>>>> Received event for $id: $event');
        });
      },
      creationParams: creationParams,
      creationParamsCodec: _decoder,
    );
  }
}
