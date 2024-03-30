import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vcard/models/contact_model.dart';
import 'package:vcard/pages/contact_details_page.dart';
import 'package:vcard/pages/contact_form.dart';
import 'package:vcard/pages/home_page.dart';
import 'package:vcard/pages/scan_page.dart';
import 'package:vcard/pages/splash_page.dart';
import 'package:vcard/providers/contact_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ContactsProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      builder: EasyLoading.init(),
      title: 'Vcard Business',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  final _router = GoRouter(debugLogDiagnostics: true, routes: [
    GoRoute(
        path: SplashPage.routeName,
        name: SplashPage.routeName,
        builder: (context, state) => const SplashPage(),
        routes: [
          GoRoute(
              name: HomePage.routeName,
              path: HomePage.routeName,
              builder: (context, state) => const HomePage(),
              routes: [
                GoRoute(
                    name: ContactDetailsPage.routeName,
                    path: ContactDetailsPage.routeName,
                    builder: (context, state) =>
                        ContactDetailsPage(id: state.extra! as int)),
                GoRoute(
                    path: ScanPage.routeName,
                    name: ScanPage.routeName,
                    builder: (context, state) => const ScanPage(),
                    routes: [
                      GoRoute(
                          path: ContactForm.routeName,
                          name: ContactForm.routeName,
                          builder: (context, state) => ContactForm(
                                contactModel: state.extra! as ContactModel,
                              ))
                    ]),
              ])
        ]),
  ]);
}
