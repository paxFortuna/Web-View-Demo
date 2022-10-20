import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _controller.goBack();
                },
                child: const Text('<-'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.goForward();
                },
                child: const Text('->'),
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.loadUrl('https://google.com');
                },
                child: const Text('google'),
              ),
            ],
          ),
          Expanded(
            child: WebView(
              // initialUrl: 'https://flutter.dev',
              initialUrl: 'https://naver.com',
              // naver등 제한 설정된 url 해제하기
              javascriptMode: JavascriptMode.unrestricted,
              // 앱에서 웹뷰 콘트롤러 설정
              onWebViewCreated: (WebViewController controller) {
                _controller = controller;
              },
            ),
          ),
        ],
      ),
    );
  }
}
