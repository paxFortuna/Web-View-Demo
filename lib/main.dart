import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
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
              ElevatedButton(
                onPressed: () {
                  _loadHtmlFromAssets();
                },
                child: const Text('assets'),
              ),

              // loadUrl에 String html 주입: 실행 안 되는 코드, html 수정 필요
              ElevatedButton(
                onPressed: () {
                  _controller.loadUrl(Uri.dataFromString(html).toString());
                },
                child: const Text('html'),
              ),
            ],
          ),
          Expanded(
            child: WebView(
              // pub add: webview_flutter
              // 기본 화면 보여준다
              // compileSdk: 32, minSdk 21
              // android/app/debug/ <Intenet permission> Manifest에 등록
              initialUrl: 'https://naver.com',

              // 모든 Http url에 접근: 네이버 처럼 접근 제한된 화면 보여준다.
              // AnroidManifest <application>에 추가
              // android:usesCleartextTraffic="true"
              // 이슈 생기면, 네이티브 안드로이드 웹뷰 자료 참고하여 수정한다
              javascriptMode: JavascriptMode.unrestricted,

              // 앱에서 '->, <-'의 웹 기능 추가 기능
              onWebViewCreated: (controller) {
                _controller = controller;
              },

              // 웹 html에서 채널로 보내준 postMessage의 set{}을 불러 가공
              // var json = { "title": "어쩌구",  "body": "저쩌구", "id": 10 };
              // myChannel.postMessage(JSON.stringify(json));
              // AnroidManifest <application>에 아래 코드 추가
              // android:usesCleartextTraffic="true"
              // assets에 html 웹 등록하여, 웹의 json 받아서, 스낵바 띄우기
              javascriptChannels: {
                JavascriptChannel(
                  name: 'myChannel',
                  onMessageReceived: (JavascriptMessage message) {
                    log(message.message);

                    Map<String, dynamic> json = jsonDecode(message.message);
                    final snackBar = SnackBar(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(json['title']),
                          Text(json['body']),
                          Text('${json['id']}'),
                        ],
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
              },
            ),
            // 아래 웹 코드 이슈 있음음
            // initialUrl: 'https://ssac-flutter.github.io/webview/',
            // javascriptChannels: {
            //                 JavascriptChannel(
            //                   name: 'myChannel',
            //                   onMessageReceived: (JavascriptMessage message) {
            //                     log(message.message);})}

          ),
        ],
      ),
    );
  }
  // assets/test.html 만든 후 punspec.yaml : assets 추가할 것
  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/test.html');
    _controller.loadUrl(
      Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ).toString(),
    );
  }
}

const html = '''
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script>
    function myClick() {
      console.log('click!!');

      var json = {
        "title": "어쩌구",
        "body": "저쩌구",
        "id": 10
      };

      myChannel.postMessage(JSON.stringify(json));
    }
  </script>
</head>
<body>
<button onclick="myClick()">클릭</button>
</body>
</html>
''';
