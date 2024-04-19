import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vinnovatelabz_app/animations/fade_in_slide.dart';
import 'package:vinnovatelabz_app/app/app_assets.dart';
import 'package:vinnovatelabz_app/app/app_const.dart';
import 'package:vinnovatelabz_app/app/app_strings.dart';
import 'package:vinnovatelabz_app/widgets/loading_overlay.dart';
import 'package:vinnovatelabz_app/app/router/app_routes.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';
import 'package:vinnovatelabz_app/features/auth/auth_controller.dart';
import 'package:vinnovatelabz_app/features/auth/auth_model.dart';
import 'package:vinnovatelabz_app/features/auth/auth_widgets/auth_widgets.dart';
import 'package:vinnovatelabz_app/services/connectivity_service.dart';
import 'package:vinnovatelabz_app/utils/logger.dart';


/// View of User login created using Firebase


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.21,
                  ),
                  FadeInSlide(
                    duration: 0.2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: MediaQuery.of(context).size.height - 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                height20,
                                FadeInSlide(duration: 0.3, child: headingWidget()),
                                height20,
                                FadeInSlide(
                                  duration: 0.35,
                                  direction: FadeSlideDirection.ltr,
                                  child: Text(
                                    'Email',
                                    style: context.tm
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                height10,
                                FadeInSlide(
                                  duration: 0.4,
                                  child: EmailField(controller: emailController),
                                ),
                                height20,
                                FadeInSlide(
                                  duration: 0.45,
                                  child: Text(
                                    'Password',
                                    style: context.tm
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                height10,
                                FadeInSlide(
                                  duration: 0.5,
                                  child:
                                      PasswordField(controller: passwordController),
                                ),
                                height10,
                                const FadeInSlide(
                                  duration: 0.52,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text('Forget Password?'),
                                  ),
                                ),
                                height20,
                                FadeInSlide(
                                  duration: 0.55,
                                  child: FilledButton(
                                    onPressed: performLogin,
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                height20,
                                height20,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  height20,
                  FadeInSlide(
                    duration: 0.6,
                    child: RichTwoPartsText(
                      text1: 'Do not have an account? ',
                      text2: 'Sign up',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  performLogin() async {
    if (_formKey.currentState!.validate()) {
      final connectivityProvider =
          Provider.of<ConnectivityProvider>(context, listen: false);
      if (connectivityProvider.isConnected) {
        LoadingScreen.instance().show(context: context, text: 'Signing in..');

        final LoginModel loginCredentials = LoginModel(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        final loginProvider =
            Provider.of<AuthController>(context, listen: false);
        final loginRes = await loginProvider.loginUser(loginCredentials);
        if (loginRes == true) {
          printSuccess('Login Success');
          await Future.delayed(const Duration(seconds: 1));
          LoadingScreen.instance().hide();
          if (mounted) context.goNamed(AppRoutes.home.name);
        } else if (loginRes.runtimeType.toString().toLowerCase() == 'string') {
          if (mounted) {
            await Future.delayed(const Duration(milliseconds: 500))
                .then((value) => LoadingScreen.instance().hide());
            if (mounted) showToast(context, loginRes, info: true);
          }
        }
      } else {
        LoadingScreen.instance().hide();
        if (mounted) {
          showToast(context, connectNetwork, info: true);
        }
      }
    } else {
      LoadingScreen.instance().hide();
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) showToast(context, 'Please fillout the fields', info: true);
    }
  }

  Widget headingWidget() {
    return Column(
      children: [
        Image.asset(
          AppAssets.loginIllus,
          height: 100,
        ),
        Text(
          'Log in',
          style: context.tl?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
