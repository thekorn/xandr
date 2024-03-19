import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xandr/ad_banner.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/load_mode.dart';
import 'package:xandr/xandr.dart';
import 'package:xandr/xandr_builder.dart';

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
      StreamController();

  @override
  void dispose() {
    _scrollController.dispose();
    _checkIfAdIsInViewport.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = XandrController();
    _scrollController.addListener(() {
      _checkIfAdIsInViewport.add(_scrollController.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('xandr sample - banner'),
      ),
      body: Center(
        child: XandrBuilder(
          controller: _controller,
          memberId: 9517, //10094,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              debugPrint('Xandr SDK initialized, success=${snapshot.hasData}');
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to m'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'fit to container:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    AdBanner(
                      controller: _controller,
                      //placementID: '17058950',
                      inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                      adSizes: const [AdSize(728, 90)], //[AdSize(300, 250)],
                      //customKeywords: useDemoAds,
                      resizeAdToFitContainer: true,
                      enableLazyLoad: true,
                    ),
                    //FIXME: not working
                    //const Text(
                    //  'Lorem Ipsum is simply dummy text of the printing and '
                    //  'typesetting industry. Lorem Ipsum has been the boo '
                    //  'standard dummy text ever since the 1500s, when an aha '
                    //  'printer took a galley of type and scrambled it to n'),
                    //const Padding(
                    //  padding: EdgeInsets.symmetric(vertical: 8),
                    //  child: Align(
                    //    alignment: Alignment.topLeft,
                    //    child: Text(
                    //      'crop to reserved space:',
                    //      style: TextStyle(
                    //        fontWeight: FontWeight.bold,
                    //      ),
                    //    ),
                    //  ),
                    //),
                    //AdBanner(
                    //  controller: _controller,
                    //  //placementID: '17058950',
                    //  inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                    //  adSizes: const [
                    //    AdSize(1, 1),
                    //    AdSize(728, 90),
                    //  ], //[AdSize(300, 250)],
                    //  width: 90,
                    //  height: 90,
                    //  //customKeywords: useDemoAds,
                    //  resizeWhenLoaded: true,
                    //),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to v'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to v'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to v'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to v'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to v'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to v'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'use winning ad size:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    AdBanner(
                      controller: _controller,
                      //placementID: '17058950',
                      inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                      adSizes: const [
                        AdSize(1, 1),
                        AdSize(728, 90),
                      ], //[AdSize(300, 250)],
                      width: 90,
                      height: 90,
                      loadsInBackground: true,
                    ),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to g'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to g'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'load when in viewport:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    AdBanner(
                      controller: _controller,
                      //placementID: '17058950',
                      inventoryCode: 'bunte_webdesktop_home_homepage_hor_1',
                      adSizes: const [
                        AdSize(728, 90),
                        AdSize(1, 1),
                      ],
                      resizeAdToFitContainer: true,
                      loadMode: LoadMode.whenInViewport(
                        _checkIfAdIsInViewport.stream,
                      ),
                    ),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to g'),
                    const Text(
                        'Lorem Ipsum is simply dummy text of the printing and '
                        'typesetting industry. Lorem Ipsum has been the boo '
                        'standard dummy text ever since the 1500s, when an aha '
                        'printer took a galley of type and scrambled it to g'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Text('Error initializing Xandr SDK');
            } else {
              return const Text('Initializing Xandr SDK...');
            }
          },
        ),
      ),
    );
  }
}
