import 'package:flutter/cupertino.dart';
import 'package:vinnovatelabz_app/features/home/home_models.dart';
import 'package:vinnovatelabz_app/features/home/home_views/home_view.dart';
import 'package:vinnovatelabz_app/features/auth/views/sign_in_view.dart';
import 'package:vinnovatelabz_app/features/auth/views/signup_view.dart';
import 'package:vinnovatelabz_app/features/home/home_views/product_description_view.dart';
import 'package:vinnovatelabz_app/features/launch/launcher_view.dart';
import 'app_routes.dart';

import 'package:go_router/go_router.dart';

/// Router configuration for application.
/// Whenever new views added, it should be configured here clearly.

final router = GoRouter(
  initialLocation: AppRoutes.launch.path,
  routes: [
    GoRoute(
      path: AppRoutes.launch.path,
      name: AppRoutes.launch.name,
      builder: (context, state) => const LaunchView(),
    ),
    GoRoute(
      path: AppRoutes.signUp.path,
      name: AppRoutes.signUp.name,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SignUpView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.signIn.path,
      name: AppRoutes.signIn.name,
      pageBuilder: (context, state) => const CupertinoPage(
        child: SignInView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      pageBuilder: (context, state) => const CupertinoPage(
        child: HomeView(),
      ),
    ),
    GoRoute(
      path: AppRoutes.productDetails.path,
      name: AppRoutes.productDetails.name,
      pageBuilder: (context, state) => CupertinoPage(
        child: ProductDetailsView(product: state.extra as ProductResponseModel),
      ),
    ),
  ],
);
