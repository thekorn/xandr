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
  late final MultiAdRequestController _multiAdRequestController;
  final ScrollController _scrollController = ScrollController();
  final StreamController<ScrollPosition> _checkIfAdIsInViewport =
      StreamController();

  @override
  void dispose() {
    _scrollController.dispose();
    _multiAdRequestController.dispose();
    _checkIfAdIsInViewport.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = XandrController()..init(9517);
    _multiAdRequestController = MultiAdRequestController(
      controller: _controller,
    )..initWhenXandrIsReady();
    _scrollController.addListener(() {
      _checkIfAdIsInViewport.add(_scrollController.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('xandr sample - multi ad request'),
      ),
      body: Center(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  _multiAdRequestController.loadAds();
                },
                child: const Text('load ads'),
              ),
              const Text(
                'typesetting industry. Lorem has been the boo '
                'standard dummy text ever sin 1500s, when an aha '
                'Lorem Ipsum is simply dummy f the printing and '
                'printer took a galley of boo it to m',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'fit to container:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AdBanner(
                controller: _controller,
                //placementID: '17058950',
                inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                adSizes: const [AdSize(728, 90)], //[AdSize(300, 250)],
                customKeywords: useDemoAds,
                resizeAdToFitContainer: true,
                multiAdRequestController: _multiAdRequestController,
              ),
              const Text(
                'Lorem Ipsum is simply text of the printing and '
                'typesetting industry. Ipsum has been the boo '
                'standard dummy text as the 1500s, when an aha '
                'printer took a galley e and scrambled it to v',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'fit to container:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AdBanner(
                controller: _controller,
                //placementID: '17058950',
                inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                adSizes: const [AdSize(728, 90)], //[AdSize(300, 250)],
                customKeywords: useDemoAds,
                resizeAdToFitContainer: true,
                multiAdRequestController: _multiAdRequestController,
              ),
              const Text(
                'Lorem Ipsum is simp du text of the printing and '
                'typesetting industry. Lo Ipsum has been the boo '
                'standard dummy text as the 1500s, when an aha '
                'printer took a galley as and scrambled it to g',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'fit to container:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              AdBanner(
                controller: _controller,
                //placementID: '17058950',
                inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                adSizes: const [AdSize(728, 90)], //[AdSize(300, 250)],
                customKeywords: useDemoAds,
                resizeAdToFitContainer: true,
                multiAdRequestController: _multiAdRequestController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
