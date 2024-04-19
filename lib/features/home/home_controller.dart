import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:vinnovatelabz_app/app/app_const.dart';
import 'package:vinnovatelabz_app/features/home/home_models.dart';
import 'package:vinnovatelabz_app/utils/logger.dart';


/// /// A change notifier class to facilitate and abstract view class from functional implementation of home feature feature.

enum FetchingEvents {
  initial,
  pickingMore,
  done,
}

class HomeProvider extends ChangeNotifier {
  HomeProvider() {
    fetchProducts(5);
    fetchingEvent = FetchingEvents.initial;
    notifyListeners();
  }

  int currentLimit = 3;
  FetchingEvents fetchingEvent = FetchingEvents.initial;
  bool didExceptionOccurred = false;

  List<ProductResponseModel>? products = [];
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.productBaseUrl,
      method: 'GET',
    ),
  );

  fetchMoreProducts(int limit) {
    fetchingEvent = FetchingEvents.pickingMore;

    notifyListeners();
    fetchProducts(limit);
  }

  Future<List<ProductResponseModel>?> fetchProducts(int limit) async {
    try {
      printInfo(
          ' $fetchingEvent fetchingProduct as ${AppConstants.productEndPoint}$limit');
      final response = await _dio.get("${AppConstants.productEndPoint}$limit");
      currentLimit = limit;
      products = productResponseModelFromJson(jsonEncode(response.data));
      printSuccess('productsFetch Successful');
      fetchingEvent = FetchingEvents.done;
      notifyListeners();
      return products;
    } catch (exc, stack) {
      printError('ExceptionCaughtWhileFetchingProducts\n $exc \n $stack');
      didExceptionOccurred = true;
      notifyListeners();
      return null;
    }
  }

  // Filter products based on search query

  List<ProductResponseModel>? filteredProducts = [];
  Future<List<ProductResponseModel>?> filterProducts(String query)async {
    if (query.length >= 3) {
      filteredProducts = products
          ?.where((product) =>
          product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
      return filteredProducts;
    } else {
      // Reset filtered products if search query is less than 3 characters
      filteredProducts = [];
      notifyListeners();
      return filteredProducts;
    }
  }


}
