import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/model/product_model.dart';

//final productProvider = Provider((ref) => ProductProvider());

class ProductProvider extends ChangeNotifier {
  List<ProductModel> carts = [];

  List<ProductModel> getProduct() => [];
  List<ProductModel> getCartItems() => carts;

  bool isAlreadyInCart(int id) =>
      carts.indexWhere((element) => element.id == id) > -1;

  Future<void> addProductToCart(ProductModel item) async {
    carts.add(item);
    notifyListeners();
  }

  num getTotalPriceInCart() {
    return carts.fold<num>(
        0, (previousValue, element) => previousValue + element.price!);
  }

  Future<void> removeProductFromCart(ProductModel item) async {
    carts.remove(item);
    notifyListeners();
  }

  List<ProductModel> flowers(List<ProductModel> products) => products
      .where((element) => element.category!.contains('Flower'))
      .toList();
  List<ProductModel> fruits(List<ProductModel> products) =>
      products.where((element) => element.category!.contains('Fruit')).toList();
  List<ProductModel> laptop(List<ProductModel> products) => products
      .where((element) => element.category!.contains('Laptop'))
      .toList();
  List<ProductModel> pizza(List<ProductModel> products) =>
      products.where((element) => element.category!.contains('Pizza')).toList();
  List<ProductModel> phone(List<ProductModel> products) =>
      products.where((element) => element.category!.contains('Phone')).toList();
  List<ProductModel> shirts(List<ProductModel> products) =>
      products.where((element) => element.category!.contains('Shirt')).toList();
  List<ProductModel> shoe(List<ProductModel> products) =>
      products.where((element) => element.category!.contains('Shoe')).toList();
}
