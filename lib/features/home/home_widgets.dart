import 'package:flutter/cupertino.dart'
    show
        CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:vinnovatelabz_app/app/app_assets.dart';
import 'package:vinnovatelabz_app/app/router/app_routes.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';
import 'package:vinnovatelabz_app/features/about_app/about_screen.dart';
import 'package:vinnovatelabz_app/features/auth/auth_controller.dart';
import 'package:vinnovatelabz_app/features/invite_friends/invite_friends_view.dart';

/// Common widgets associated with home feature


class StarRating extends StatelessWidget {
  final double rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    const double starSize = 20;
    return Row(
      children: List<Widget>.generate(5, (index) {
        double starRating = rating - index;
        return Container(
          child: starRating >= 1
              ? const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: starSize,
                )
              : starRating >= 0.5
                  ? const Icon(
                      Icons.star_half,
                      color: Colors.yellow,
                      size: starSize,
                    )
                  : const Icon(
                      Icons.star_border,
                      color: Colors.yellow,
                      size: starSize,
                    ),
        );
      }),
    );
  }
}

class LoadingMoreWidget extends StatefulWidget {
  const LoadingMoreWidget({super.key});

  @override
  State<LoadingMoreWidget> createState() => _LoadingMoreWidgetState();
}

class _LoadingMoreWidgetState extends State<LoadingMoreWidget> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading... Please wait  ',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          CupertinoActivityIndicator(),
        ],
      ),
    );
  }
}

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final List<String> drawerItemList = ['Home', 'Invite Friends', 'About'];

  final List<String> drawerImages = [
    'assets/icons/home.png',
    'assets/icons/invitation.png',
    'assets/icons/info.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            color: context.theme.primaryColor,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppAssets.appIcon1,
                      width: MediaQuery.of(context).size.width * 0.14,
                      color: const Color(0xFFf8f8f8),
                    ),
                    const Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            'VinShop',
                            style: TextStyle(
                              color: Color(0xFFf8f8f8),
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Text(
                          'Shop the Best',
                          style: TextStyle(
                            color: Color(0xFFf8f8f8),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          for (var drawerIndex = 0;
              drawerIndex < drawerItemList.length;
              drawerIndex++)
            DrawerItemWidget(
              onTap: () => changeThePage(drawerIndex, context),
              leadingItemUrl: drawerImages[drawerIndex],
              titleText: drawerItemList[drawerIndex],
              index: drawerIndex,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading:
                  Icon(IconlyLight.logout, color: context.theme.primaryColor),
              title: Text(
                'Logout',
                style: context.tm?.copyWith(color: context.theme.primaryColor),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            final k = await Provider.of<AuthController>(context,
                                    listen: false)
                                .logout();
                            if (k && context.mounted) {
                              context.goNamed(AppRoutes.signIn.name);
                            }
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          const Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'All Right Reserved ©',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  changeThePage(index, BuildContext context) {
    switch (index) {
      case 0:
        Scaffold.of(context).closeDrawer();
        break;
      case 1:
        Scaffold.of(context).closeDrawer();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) => const InviteFriendsScreen()));
        break;
      case 2:
        Scaffold.of(context).closeDrawer();
        Navigator.push(context,
            MaterialPageRoute(builder: (builder) => const AboutScreen()));
        break;
    }
  }
}

class DrawerItemWidget extends StatelessWidget {
  final Function()? onTap;
  final String? leadingItemUrl;
  final String? titleText;
  final int index;

  const DrawerItemWidget({
    super.key,
    this.onTap,
    this.leadingItemUrl,
    this.titleText,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        // tileColor: Theme.of(context).col,
        leading: AspectRatio(
            aspectRatio: index == 1
                ? 0.5 / 1.68
                : index == 2
                    ? 0.5 / 1.2
                    : 0.5 / 1.5,
            child: Image.asset(
              leadingItemUrl ?? '',
              height: 30,
              width: 30,
              // color: Theme.of(context).highlightColor,
            )),
        title: Text(
          titleText ?? '',
          // color: Theme
          //     .of(context)
          //     .highlightColor,
        ),
      ),
    );
  }
}
