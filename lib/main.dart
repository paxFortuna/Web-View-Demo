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
      home: App(),
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

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _loadHtmlFromAssets_2();
                  },
                  child: const Text('calender'),
                ),
              ),

              // loadUrl??? String html ??????: ?????? ??? ?????? ??????, html ?????? ??????
              // ElevatedButton(
              //   onPressed: () {
              //     _controller.loadUrl(Uri.dataFromString(html).toString());
              //   },
              //   child: const Text('html'),
              // ),
            ],
          ),
          Expanded(
            child: WebView(
              // pub add: webview_flutter
              // ?????? ?????? ????????????
              // compileSdk: 32, minSdk 21
              // android/app/debug/ <Intenet permission> Manifest??? ??????

              initialUrl: 'https://naver.com',
              //initialUrl: 'https://github.com/paxFortuna/Web-RentCar1-Jsp/WebContent/BoardIndex.jsp',

              // ?????? Http url??? ??????: Cleartext Http not permitted in android
              // ????????? ?????? ?????? ????????? ?????? ????????????.
              // AnroidManifest <application>??? ??????
              // android:usesCleartextTraffic="true"
              // ?????? ?????????, ???????????? ??????????????? ?????? ?????? ???????????? ????????????
              javascriptMode: JavascriptMode.unrestricted,

              // ????????? '->, <-'??? ??? ?????? ?????? ??????
              onWebViewCreated: (controller) {
                _controller = controller;
              },

              // ??? html?????? ????????? ????????? postMessage??? set{}??? ?????? ??????
              // var json = { "title": "?????????",  "body": "?????????", "id": 10 };
              // myChannel.postMessage(JSON.stringify(json));
              // AnroidManifest <application>??? ?????? ?????? ??????
              // android:usesCleartextTraffic="true"
              // assets??? html ??? ????????????, ?????? json ?????????, ????????? ?????????
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
          ),
        ],
      ),
    );
  }

  // assets/test.html ?????? ??? punspec.yaml : assets ????????? ???
  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString("assets/test.html");
    _controller.loadUrl(
      Uri.dataFromString(
        fileText,
        mimeType: "text/",
        encoding: Encoding.getByName("utf-"),
      ).toString(),
    );
  }

  _loadHtmlFromAssets_2() async {
    String fileText_2 = await rootBundle.loadString("assets/js_calender/index.html");
    _controller.loadUrl(Uri.dataFromString(fileText_2).toString());
  }
}

// const html = '''
// <!DOCTYPE html>
// <html lang="en">
// <head>
//     <meta charset="UTF-8">
//     <meta http-equiv="X-UA-Compatible" content="IE=edge">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>Document</title>
//     <script>
//     function myClick() {
//       console.log('click!!');
//
//       var json = {
//         "title": "?????????",
//         "body": "?????????",
//         "id": 10
//       };
//
//       myChannel.postMessage(JSON.stringify(json));
//     }
//   </script>
// </head>
// <body>
// <button onclick="myClick()">??????</button>
// </body>
// </html>
// ''';
