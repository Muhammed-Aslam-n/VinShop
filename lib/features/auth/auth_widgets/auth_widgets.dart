import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:vinnovatelabz_app/app/app_strings.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';
import 'package:vinnovatelabz_app/utils/validators_and_extenstions.dart';

/// Widgets that are commonly used for authentication feature

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String text;

  const LoginButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(.05),
        side: BorderSide(color: Colors.grey.shade800, width: .1),
        fixedSize: const Size.fromHeight(50),
        padding: const EdgeInsets.symmetric(horizontal: 15),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              )),
          Align(alignment: Alignment.centerLeft, child: icon),
        ],
      ),
    );
  }
}

class RichTwoPartsText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const RichTwoPartsText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: context.tm?.copyWith(color: Colors.grey),
        text: text1,
        children: [
          TextSpan(
            text: text2,
            style: context.tm
                ?.copyWith(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 17),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  ValueNotifier<bool> obscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: obscure,
        builder: (context, b, k) {
          return TextFormField(
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus!.unfocus(),
            controller: widget.controller,
            // cursorColor: isDark ? Colors.grey : Colors.black54,
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscure.value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blueGrey.withOpacity(.1),
              hintText: "Password",
              prefixIcon: const Icon(IconlyLight.lock, size: 20),
              suffixIcon: IconButton(
                icon: obscure.value
                    ? const Icon(IconlyLight.hide)
                    : const Icon(IconlyLight.show),
                onPressed: () {
                  obscure.value = !obscure.value;
                },
              ),
              // prefixIconColor: isDark ? Colors.white : Colors.black87,
              // suffixIconColor: isDark ? Colors.white : Colors.black87,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [PasswordInputFormatter()],
            validator: (String? password) {
              if (password == null || password.isEmpty) {
                return noEmailMsg;
              }
              final invalidReason = password.invalidPasswordReason;
              if (invalidReason != null) {
                return invalidReason;
              }
              return null;
            },
          );
        });
  }
}


class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      // cursorColor: isDark ? Colors.grey : Colors.black54,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.blueGrey.withOpacity(.1),
        hintText: "Email",
        prefixIcon: const Icon(IconlyLight.message,),
        // prefixIconColor: isDark ? Colors.white : Colors.black87,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (String? username) {
        if (username == null || username.isEmpty) {
          return noUsernameMsg;
        }
        final invalidReason = username.invalidEmailReason;
        if (invalidReason != null) {
          return invalidReason;
        }
        return null;
      },
    );
  }
}



hideToast(BuildContext context) =>
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

showToast(
    BuildContext context,
    String message, {
      Color? messageColor,
      Color? bgColor,
      Color? textColor,
      bool info = false,
      success = false,
      failure = false,
      Duration? duration,
    }) {
  if (context.mounted) {
    final SnackBar snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(15),
        duration: duration ?? const Duration(seconds: 2),
        backgroundColor: info
            ? Colors.orange
            : success
            ? Colors.green
            : failure
            ? Colors.redAccent
            : bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: Text(
          message,
          style: TextStyle(color: messageColor ?? Colors.white),
        ));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}