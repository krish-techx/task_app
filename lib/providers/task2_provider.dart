import 'package:flutter/material.dart';
import 'package:task_app/core/enums/page_state.dart';
import 'package:task_app/modals/task2_product_modal.dart';
import 'package:task_app/services/api_service.dart';

class Task2Provider extends ChangeNotifier {
  Task2Provider() {
    _initPage();
  }

  PageState _pageState = PageState.initial;

  PageState get pageState => _pageState;

  List<Task2ProductModal> _productList = [];
  List<Task2ProductModal> get productList => _productList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> _initPage() async {
    try {
      _pageState = PageState.loading;
      notifyListeners();

      await _callApi();

      if (_productList.isEmpty) {
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

  Future<void> _callApi() async {
    final response = await ApiService.instance.fetchTask2Product();

    final data = response.data;
    if (response.statusCode == 200 && data != null) {
      List listData = data ?? [];

      _productList = listData
          .map<Task2ProductModal>(
            (e) => Task2ProductModal.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }
  }
}
