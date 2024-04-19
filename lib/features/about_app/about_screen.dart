import 'package:flutter/material.dart';
import 'package:vinnovatelabz_app/widgets/app_bar.dart';

/// An simple details section of the application with version and other developer descriptions

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SizedBox sizedBox = SizedBox(
      height: MediaQuery.of(context).size.height * 0.03,
    );
    return Scaffold(
      appBar: const AppBarWidget(
        appBarHeight: 60,
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizedBox,
            sizedBox,
            const Text(
              "VinShop is your go-to shopping destination, offering a seamless experience for the latest\n trends in fashion, electronics, home decor, and more. Our user-friendly platform provides a wide\n array of high-quality products at affordable prices. With a commitment to customer satisfaction, we strive\n to deliver convenience through a secure shopping environment and swift delivery services. Embrace an enjoyable and hassle-free shopping journey, accompanied by exclusive deals and personalized recommendations. Join us in exploring a world of endless possibilities and unparalleled convenience. At VinShop, we're dedicated to elevating your shopping experience to the next level.",
            ),
            sizedBox,
            const Text(
              'Thank you for choosing VinShop. We hope it serves your needs and respects your privacy.',
              // fontStyle: FontStyle.italic,
              // fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
