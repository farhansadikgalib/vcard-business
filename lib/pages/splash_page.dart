import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = 'splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  initState() {
    super.initState();
    Future.delayed( Duration(seconds: 3), () {
      context.goNamed(HomePage.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('SplashPage'),
          ],
        ),
      ),
    );
  }
}
