import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vinnovatelabz_app/app/app_assets.dart';
import 'package:vinnovatelabz_app/app/app_const.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';
import 'package:vinnovatelabz_app/features/home/home_models.dart';
import 'package:vinnovatelabz_app/utils/logger.dart';

import '../home_widgets.dart';


/// Widget to show detailed products view

class ProductDetailsView extends StatefulWidget {
  final ProductResponseModel product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final ProductResponseModel product;

  @override
  void initState() {
    product = widget.product;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    printInfo('productReceived ${jsonEncode(widget.product)}');
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.chevron_left,
        ),
        title: const Text(
          'Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.width-50,
              child: product.image!=null && product.image!.isNotEmpty?Image.network(product.image!):Image.asset(AppAssets.noDataImage2),
            ),
            Container(
              height: MediaQuery.of(context).size.width,
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(60),
                ),
                color: Theme.of(context).colorScheme.copyWith(primary: const Color(0xFF191e39)).primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    height10,
                    Text(
                      product.title ?? 'Title',
                      style: const TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    height10,

                    ProductDescriptionWidget(description: product.description??'kjhbdfjkashabdkajsbdasbdfjasbdjfahsvdfjkasvdfkjasdvfjkadvfjhsdvfkjsddvfjasbfkjsdabfhfbjfbkjasdbfkbdfjkasdbfjasbfhjasfksdf'),

                    height20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: StarRating(
                                    rating: product.rating?.rate ?? 0),
                              ),
                              width5,
                              Text(
                                "( ${product.rating?.rate ?? '0'} )",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              width5,
                              Text(
                                "( ${product.rating?.count ?? '0'} )",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Text(
                            product.price.toString().toLowerCase() != 'free'
                                ? '\$ ${product.price}'
                                : 'Free',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 24.5,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    height15,
                    FilledButton(onPressed: (){}, child: Text('Buy',style: context.tl?.copyWith(color: Colors.white,fontWeight: FontWeight.w600),)),
                    height10,

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

class ProductDescriptionWidget extends StatefulWidget {
  final String description;
  const ProductDescriptionWidget({super.key, required this.description});

  @override
  State<ProductDescriptionWidget> createState() => _ProductDescriptionWidgetState();
}

class _ProductDescriptionWidgetState extends State<ProductDescriptionWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const SizedBox(height: 8.0),
        _isExpanded
            ? Text(widget.description,style: context.ts?.copyWith(color: Colors.white),)
            : Text(
          widget.description.length > 100
              ? '${widget.description.substring(0, 100)}...'
              : widget.description,
          style: context.ts?.copyWith(color: Colors.white,fontSize: 18),
        ),
        const SizedBox(height: 8.0),
        widget.description.length > 100
            ? InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Text(
            _isExpanded ? 'Show less' : 'Show more',
            style: context.ts?.copyWith(color: Colors.blueAccent),
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}

