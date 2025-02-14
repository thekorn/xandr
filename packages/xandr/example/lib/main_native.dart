import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xandr/ad_banner.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/xandr.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const XandrExample(),
    );
  }
}

class XandrExample extends StatefulWidget {
  const XandrExample({super.key});

  @override
  State<XandrExample> createState() => _XandrExampleState();
}

class _XandrExampleState extends State<XandrExample> {
  late final XandrController _controller;
  final ScrollController _scrollController = ScrollController();
  final StreamController<ScrollPosition> _checkIfAdIsInViewport =
      StreamController.broadcast();

  @override
  void dispose() {
    _scrollController.dispose();
    _checkIfAdIsInViewport.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = XandrController()..init(9517, testMode: true);
    _scrollController.addListener(() {
      _checkIfAdIsInViewport.add(_scrollController.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('xandr sample - banner'),
        ),
        body: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'native ad below:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                AdBanner(
                  controller: _controller,
                  inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                  adSizes: const [AdSize(1, 1)],
                  customKeywords: const {
                    'kw': ['test-kw', 'demoads_native'],
                  },
                  onBannerFinishLoading: ({
                    required success,
                    height,
                    width,
                    nativeAd,
                  }) =>
                      debugPrint(
                    'on native banner finish loading: success: $success',
                  ),
                  autoRefreshInterval: Duration.zero,
                  clickThroughAction: ClickThroughAction.returnUrl,
                  onAdClicked: (url) => debugPrint('click url: $url'),
                  allowNativeDemand: true,
                  nativeAdRendererId: 1,
                  nativeAdBuilder: (nativeAd) => InkWell(
                    onTap: () => debugPrint(
                      'native ad click: ${nativeAd.clickUrl}',
                    ),
                    child: ColoredBox(
                      color: Colors.amber,
                      child: Column(
                        children: [
                          Text(nativeAd.title),
                          Text(nativeAd.description),
                          Image.network(nativeAd.imageUrl),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
