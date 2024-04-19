import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vinnovatelabz_app/animations/fade_in_slide.dart';
import 'package:vinnovatelabz_app/app/app_assets.dart';
import 'package:vinnovatelabz_app/app/app_const.dart';
import 'package:vinnovatelabz_app/app/router/app_routes.dart';
import 'package:vinnovatelabz_app/app/theme/text_style_ext.dart';
import 'package:vinnovatelabz_app/features/home/home_controller.dart';
import 'package:vinnovatelabz_app/features/home/home_models.dart';
import 'package:vinnovatelabz_app/features/home/home_widgets.dart';
import 'package:vinnovatelabz_app/services/connectivity_service.dart';
import 'package:vinnovatelabz_app/widgets/status_widgets.dart';

/// Home view after user successfully logged in

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f8f8),
      drawer: const DrawerWidget(),

      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        // backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.academyAppbarIconCropped,
              height: 30,
            ),
            Text(
              'academy',
              style: context.tl,
            ),
          ],
        ),
      ),
      body: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  // final ScrollController controller;
  const ProductList({
    super.key,
  });

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        provider.fetchProducts(provider.currentLimit + 5);
        provider.fetchingEvent = FetchingEvents.pickingMore;
        provider.notifyListeners();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivity, _) {
        if (!connectivity.isConnected) {
          return const Column(
            children: [
              SizedBox(
                height: 150,
              ),
              NoNetworkWidget(),
            ],
          );
        }
        return Consumer<HomeProvider>(
          builder: (context, provider, _) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (provider.fetchingEvent == FetchingEvents.initial)
                    const LoadingWidget(),
                  if (provider.didExceptionOccurred)
                    const ErrorOccurredWidget(),
                  if (provider.products == null) const NoDataFoundWidget(),
                  if (provider.products != null &&
                      provider.products!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TypeAheadField<ProductResponseModel>(
                        hideKeyboardOnDrag: true,
                        suggestionsCallback: (search) {
                          if (search.length >= 3) {
                            return provider.filterProducts(search);
                          }
                          return null;
                        },
                        builder: (context, controller, focusNode) {
                          return TextField(
                            onTapOutside: (k) =>
                                FocusManager.instance.primaryFocus!.unfocus,
                            controller: controller,
                            focusNode: focusNode,
                            autofocus: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey.withOpacity(.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              labelText: 'Search loaded products',
                            ),
                          );
                        },
                        itemBuilder: (context, product) {
                          return ListTile(
                            title: Text(product.title ?? 'Not found'),
                            subtitle: Text(product.category ?? 'Not found'),
                            onTap: () {
                              FocusManager.instance.primaryFocus!.unfocus();
                              context.pushNamed(AppRoutes.productDetails.name,
                                  extra: product);
                            },
                          );
                        },
                        onSelected: (product) {},
                      ),
                    ),
                  if (provider.products != null &&
                      provider.products!.isNotEmpty)
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Showing 14 Courses',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                  if (provider.products != null &&
                      provider.products!.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ProductResponseModel product =
                            provider.products![index];
                        return FadeInSlide(
                          duration: 0.6,
                          direction: FadeSlideDirection.ltr,
                          child: ProductItemWidget(product: product),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return height10;
                      },
                      itemCount: provider.products!.length,
                    ),
                  if (provider.fetchingEvent == FetchingEvents.pickingMore)
                    const LoadingMoreWidget(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ProductItemWidget extends StatelessWidget {
  final ProductResponseModel product;

  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () =>
          context.pushNamed(AppRoutes.productDetails.name, extra: product),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
        margin: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: width * 0.2,
              width: width * 0.22,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: product.image!.isNotEmpty
                      ? NetworkImage(product.image!)
                      : const AssetImage(AppAssets.noImageForProduct)
                          as ImageProvider,
                ),
              ),
            ),
            width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // height20,
                  Text(
                    product.title ?? 'Title not found',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  height5,
                  Text(
                    product.category ?? '',
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                  ),
                  height5,
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  StarRating(rating: product.rating?.rate ?? 0),
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
                              fontWeight: FontWeight.w600, fontSize: 12.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
