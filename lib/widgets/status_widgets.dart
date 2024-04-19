import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vinnovatelabz_app/app/app_assets.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';

/// Custom widget to show illustrated views for network related and response related errors, exceptions etc.

class NoNetworkWidget extends StatelessWidget {
  const NoNetworkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(
            AppAssets.noNetwork,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
          Text(
            'No network available.',
            style: context.tm?.copyWith(fontSize: 22),
          ),
          Text(
            'Please connect and try again.',
            style: context.tm?.copyWith(fontSize: 18),
          )
        ],
      ),
    );
  }
}

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [

          SizedBox(
            height: MediaQuery.of(context).size.width * 0.3,
          ),
          Image.asset(
            AppAssets.noDataImage1,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
          const Text('No Data Found',style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.3,
          ),
          Image.asset(
            AppAssets.errorOccurred1,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
          const Text('Some Error Occurred!',style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }
}

class UnexpectedWidget extends StatelessWidget {
  const UnexpectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.3,
          ),
          Image.asset(
            AppAssets.unexpected1,
            height: MediaQuery.of(context).size.width * 0.5,
          ),
          const Text('Oops! You got us here.',style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
          ),
          SpinKitFadingCircle(
            color: Theme.of(context).colorScheme.primary,
            size: 60,
          ),
        ],
      ),
    );
  }
}
