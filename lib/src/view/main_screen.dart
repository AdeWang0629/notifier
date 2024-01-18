import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notifer/src/controller/auth_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_js/flutter_js.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  late final WebViewController controller;
  static String JsController = '''''';
  String? message;
  
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          controller.runJavaScriptReturningResult('<script language="JavaScript" type="text/javascript">alert("Hello World")</script>');

        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {
          
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://toshinliner.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        
      ),
    )
    ..loadRequest(Uri.parse('https://toshinliner.com/'))
    ..addJavaScriptChannel("myChannel",
          onMessageReceived: (JavaScriptMessage message) {
        setMessage(message.message);
    });
  }

  setMessage(String javascriptMessage) {
    if (mounted) {
      setState(() {
        message = javascriptMessage;
      });
    }
  }

  injectJavascript(WebViewController controller) async {
    controller.runJavaScript('''
    var menuBar = document.getElementById('mobile');
    if (menuBar != null) {
      menuBar.style.display = 'none';
    }
    ''');
  }

  @override
  void dispose() {
    super.dispose();
  }


  //build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Integrate Flutter and Webview')),
      body: WebViewWidget(controller: controller),
    );
  }
}
