import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vinnovatelabz_app/app/app_const.dart';
import 'package:vinnovatelabz_app/app/router/router.dart';
import 'package:vinnovatelabz_app/app/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:vinnovatelabz_app/features/auth/auth_controller.dart';
import 'package:vinnovatelabz_app/features/home/home_controller.dart';
import 'package:vinnovatelabz_app/services/connectivity_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: AppConstants.firebaseApiKey,
            appId: AppConstants.firebaseAppId,
            messagingSenderId: AppConstants.messagingSenderId,
            projectId: AppConstants.projectId,
            storageBucket: AppConstants.storageBucket,
          ),
        )

      ///ios file credentials goes here
      : await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (instance) => AuthController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (instance) => ConnectivityProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (instance) => HomeProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
  ConnectivityProvider().initConnectivity();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
