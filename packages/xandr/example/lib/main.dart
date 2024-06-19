import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xandr/ad_banner.dart';
import 'package:xandr/ad_size.dart';
import 'package:xandr/load_mode.dart';
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

    _controller = XandrController()..init(9517);
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
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const Text('Lorem Ipsum is simply dummy text of the printing and '
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
                inventoryCode: 'bunte_androidapp_fuermich_frontpage_hor_2',
                adSizes: const [AdSize(300, 250)],
                //customKeywords: const {
                //  'kw': ['test-kw', 'demoads'],
                //},
                resizeAdToFitContainer: true,
                enableLazyLoad: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
