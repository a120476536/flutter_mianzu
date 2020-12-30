import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_mianzu/router/application.dart';
import 'package:flutter_mianzu/router/routers.dart';

void main() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }



  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp(){
    WidgetsFlutterBinding.ensureInitialized();
    FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
    );
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData( primaryColor: Colors.deepOrangeAccent,
      ),
      title: "免租",
      onGenerateRoute: Application.router.generator,
    );
  }
}

