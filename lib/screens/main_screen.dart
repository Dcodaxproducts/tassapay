// ignore_for_file: implementation_imports

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prime_web/helpers/Colors.dart';
import 'package:provider/src/provider.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '../helpers/Constant.dart';
import '../provider/navigationBarProvider.dart';
import '../screens/home_screen.dart';

class MyHomePage extends StatefulWidget {
  final String webUrl;
  final bool isDeepLink;
  const MyHomePage({Key? key, required this.webUrl, required this.isDeepLink})
      : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController idleAnimation;
  late AnimationController onSelectedAnimation;
  late AnimationController onChangedAnimation;
  Duration animationDuration = const Duration(milliseconds: 700);
  late AnimationController navigationContainerAnimationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    Future.delayed(Duration.zero, () {
      context
          .read<NavigationBarProvider>()
          .setAnimationController(navigationContainerAnimationController);
    });
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await OneSignal.shared.setAppId(
        Platform.isAndroid ? oneSignalAndroidAppId : oneSignalIOSAppId);
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      debugPrint(
          'NOTIFICATION OPENED HANDLER CALLED WITH: ${result.notification.launchUrl}');
      if (result.notification.launchUrl != null) {
        setState(() {
          webinitialUrl = result.notification.launchUrl.toString();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (_) => MyHomePage(
                      webUrl: webinitialUrl,
                      isDeepLink: true,
                    )),
            (route) => false,
          );
        });
      }
    });

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      setState(() {
        debugPrint(
            "Notification received in foreground notification: \n${event.notification.launchUrl}");
      });
    });
  }

  @override
  void dispose() {
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
    navigationContainerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _navigateBack(context),
      child: SafeArea(
        top: Platform.isIOS ? false : true,
        bottom: Platform.isIOS ? false : true,
        child: Column(
          children: [
            const Expanded(child: HomeScreen(firstTabUrl, false, false)),
            Container(height: 0, color: primaryColor),
          ],
        ),
      ),
    );
  }

  Future<bool> _navigateBack(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Do you want to exit app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            ));

    return Future.value(true);
  }
}
