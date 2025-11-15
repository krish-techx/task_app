import 'package:flutter/material.dart';
import 'package:task_app/core/enums/page_state.dart';
import 'package:task_app/modals/product_modal.dart';
import 'package:task_app/services/api_service.dart';

class Task1Provider extends ChangeNotifier {
  Task1Provider() {
    _initPage();
  }

  static const int _itemsPerPage = 10;

  PageState _pageState = PageState.initial;

  PageState get pageState => _pageState;

  List<ProductModal> _allProductList = [];
  List<ProductModal> get allProductList => _allProductList;

  List<ProductModal> _loadedProductList = [];

  List<ProductModal> get loadedProductList => _loadedProductList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> _initPage() async {
    try {
      _pageState = PageState.loading;
      notifyListeners();

      await _callApi();
      await onMaxExtent();

      if (_allProductList.isEmpty) {
        _pageState = PageState.empty;
      } else {
        _pageState = PageState.success;
      }
    } catch (e) {
      _pageState = PageState.error;
      _errorMessage = '$e';
    } finally {
      notifyListeners();
    }
  }

  Future<void> onMaxExtent() async {
    final List<ProductModal> newList = [];

    for (
      int i = loadedProductList.length;
      i < loadedProductList.length + _itemsPerPage;
      i++
    ) {
      if (i >= allProductList.length) {
        break;
      }
      newList.add(allProductList[i]);
    }

    _loadedProductList = loadedProductList + newList;
    notifyListeners();
  }

  Future<void> _callApi() async {
    final response = await ApiService.instance.fetchProduct();

    final data = response.data;
    if (response.statusCode == 200 && data != null) {
      List listData = data['products'] ?? [];
      _allProductList = listData
          .map<ProductModal>(
            (e) => ProductModal.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }
  }
}
