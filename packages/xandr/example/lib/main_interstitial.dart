import 'package:flutter/material.dart';
import 'package:xandr/ad_interstitial.dart';
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
    return const MaterialApp(home: XandrExample());
  }
}

class XandrExample extends StatefulWidget {
  const XandrExample({super.key});

  @override
  State<XandrExample> createState() => _XandrExampleState();
}

class _XandrExampleState extends State<XandrExample> {
  late final XandrController _controller;
  late final InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();

    _controller = XandrController();
    _interstitialAd = InterstitialAd(
      controller: _controller,
      inventoryCode: 'bunte_webphone_news_gallery_oop_0',
      //customKeywords: useDemoAds,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: XandrBuilder(
        controller: _controller,
        memberId: 9517, //10094,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            debugPrint('Xandr SDK initialized, success=${snapshot.hasData}');
            return XandrInterstitialBuilder(
              interstitialAd: _interstitialAd,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  debugPrint('Xandr interstitial ad loaded, '
                      'success=${snapshot.hasData}');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          debugPrint('show interstitial ad...');
                          final result =
                              await _interstitialAd.show(autoDismissDelay: 10);
                          debugPrint(
                            'interstitial ad has been closed result=$result',
                          );
                        },
                        child: const Text('Show Interstitial Ad'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error loading Xandr interstitial ad');
                } else {
                  return const Text('Loading Xandr interstitial ad...');
                }
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Error initializing Xandr SDK');
          } else {
            return const Text('Initializing Xandr SDK...');
          }
        },
      ),
    );
  }
}
