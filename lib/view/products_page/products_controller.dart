import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:restaurant_go/model/product_model.dart';
import 'package:restaurant_go/services/api_service.dart';

class ProductsController extends GetxController {
  final RxList<ProductModel> _productsList = <ProductModel>[].obs;
  List<ProductModel> get productsList => _productsList;

  final RxList<ProductModel> _allProducts = <ProductModel>[].obs;
  List<ProductModel> get allProducts => _allProducts;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final TextEditingController _textEditingController = TextEditingController();
  TextEditingController get textEditingController => _textEditingController;

  @override
  void onInit() async {
    _productsList.value = await ApiService.getAllProducts();
    _allProducts.value = List.from(_productsList);
    super.onInit();
  }

  void onTextfieldChanged(String query) async {
    Set<ProductModel> produtosEncontrados;

    produtosEncontrados = Set<ProductModel>.from(_productsList.where(
        (item) => item.item.toLowerCase().contains(query.toLowerCase())));

    _productsList.clear();

    _isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading.value = false;

    _productsList.addAll(produtosEncontrados);

    if (query.isEmpty) {
      _productsList.addAll(_allProducts);
    }
  }
}
