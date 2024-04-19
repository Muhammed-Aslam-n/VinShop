import 'package:flutter/material.dart';
import 'package:vinnovatelabz_app/features/auth/auth_widgets/auth_widgets.dart';
import 'package:vinnovatelabz_app/widgets/app_bar.dart';

/// Widget to share invite to others

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  final String inviteLink = '';

  void shareInviteLink(BuildContext context) {
    showToast(context, 'Feature coming soon...',info: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        appBarHeight: 60,
        title: Text('Invite Friends'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text('VinShop',),
            const SizedBox(height: 60),
            const Text(
                  'Discover the joy of shopping together! Share the excitement of exclusive deals, endless choices, and unbeatable discounts with your friends. Invite them to join our shopping community and unlock amazing rewards for both you and your friends. With a plethora of options and fantastic savings, together, we can redefine the shopping experience. Start the trend and spread the joy of shopping with friends today!',

            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                shareInviteLink(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                fixedSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              child: const Text('Share Invite Link'),
            ),
          ],
        ),
      ),
    );
  }
}
