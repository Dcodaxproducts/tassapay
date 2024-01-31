import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prime_web/helpers/Strings.dart';
import '../helpers/Colors.dart';
import '../helpers/Constant.dart';
import '../main.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    const duration = Duration(seconds: 3);
    return Timer(duration, () {
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(
          builder: (_) => MyHomePage(
                webUrl: webinitialUrl,
                isDeepLink: false,
              )));
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    return Scaffold(
      body: Container(
          padding: EdgeInsets.zero,
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          color: primaryColor,
          child: Center(
            child: Image.asset(
              splashLogo,
              width: 200,
              height: 200,
            ),
          )),
    );
  }
}
