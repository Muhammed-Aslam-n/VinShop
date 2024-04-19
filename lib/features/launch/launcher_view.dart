import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vinnovatelabz_app/app/app_assets.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';
import 'package:vinnovatelabz_app/utils/logger.dart';

import '../../app/router/app_routes.dart';

/// Widget shown when application launched with app icon

class LaunchView extends StatefulWidget {
  const LaunchView({super.key});

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;
  bool showSubText = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
        if (_fontSize == 1.06) {
          showSubText = false;
        }
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(const Duration(seconds: 4), () {
      setState(() {
        _isLoading = false;
        printInfo('isLoadingValue $_isLoading');

        _checkAuthState();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = true;

  void _checkAuthState() async {
    if (_isLoading == false) {
      _auth.authStateChanges().listen((event) {
        printSuccess('AuthStateChangedInLauncherView ${event == null}');
        if (event == null && mounted) {
          context.goNamed(AppRoutes.signIn.name);
        } else {
          if (mounted) context.goNamed(AppRoutes.home.name);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: launcherWidget(),
      ),
    );
  }

  Widget launcherWidget() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _fontSize),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastLinearToSlowEaseIn,
                height: width / _containerSize,
                width: width / _containerSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const Expanded(
                      child: Image(
                        image: AssetImage(AppAssets.appIcon1),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'VinShop',
                      style: context.tl
                          ?.copyWith(color: context.theme.primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> addSomeDelay() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return Future.value(true);
  }
}
