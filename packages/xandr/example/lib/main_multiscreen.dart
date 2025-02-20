import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Navigation App',
      // Define the initial route
      initialRoute: '/',
      // Define the routes for the app
      routes: {
        '/': (context) => Screen1(),
        '/screen2': (context) => Screen2(),
        '/screen3': (context) => Screen3(),
      },
    );
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Screen 2
                Navigator.pushNamed(context, '/screen2');
              },
              child: Text('Go to Screen 2'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Screen 3
                Navigator.pushNamed(context, '/screen3');
              },
              child: Text('Go to Screen 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Screen 1
                Navigator.pushNamed(context, '/');
              },
              child: Text('Go to Screen 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Screen 3
                Navigator.pushNamed(context, '/screen3');
              },
              child: Text('Go to Screen 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 3')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Screen 1
                Navigator.pushNamed(context, '/');
              },
              child: Text('Go to Screen 1'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to Screen 2
                Navigator.pushNamed(context, '/screen2');
              },
              child: Text('Go to Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}
