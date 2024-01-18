import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:notifer/src/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notifer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization here
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    await Firebase.initializeApp(
      // name: 'Notifans',
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(const ProviderScope(child: Notifer()));
}
