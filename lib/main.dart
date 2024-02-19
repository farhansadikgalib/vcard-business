import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vcard/pages/home_page.dart';
import 'package:vcard/pages/scan_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  final _router = GoRouter(debugLogDiagnostics: true, routes: [
    GoRoute(
        name: HomePage.routeName,
        path: HomePage.routeName,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              path: ScanPage.routeName,
              name: ScanPage.routeName,
              builder: (context, state) => const ScanPage())
        ])
  ]);
}
