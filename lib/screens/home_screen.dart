// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/load_web_view.dart';

class HomeScreen extends StatefulWidget {
  final String url;
  final bool mainPage;
  final bool isDeepLink;
  final Function? callback;
  const HomeScreen(this.url, this.mainPage, this.isDeepLink,
      {Key? key, this.callback})
      : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
        systemNavigationBarColor: Theme.of(context).primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));
    return Container(
      color: Color(0xFF4154AF),
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: LoadWebView(
        url: widget.url,
        webUrl: true,
        isDeepLink: false,
        isMainPage: widget.mainPage,
      ),
    );
  }
}
