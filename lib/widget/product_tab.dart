import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/model/product_model.dart';

import '../provider/product_provider.dart';
import 'product_list.dart';

final productFutureProvider = FutureProvider((ref) async {
  return ref.read(productProvider).getProduct();
});

class ProductTab extends StatefulWidget {
  const ProductTab({Key? key}) : super(key: key);

  @override
  State<ProductTab> createState() => _ProductTabState();
}

class _ProductTabState extends State<ProductTab> {
  int currentIndex = 0;
  final tabs = [
    'All',
    'Flower',
    'Fruit',
    'Laptop',
    'Pizza',
    'Phone',
    'Shirt',
    'Shoe'
  ];
  final controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return SafeArea(
          minimum: const EdgeInsets.all(16.0),
          child: ref.watch(productFutureProvider).when(
              data: (items) => Column(
                    children: [
                      SingleChildScrollView(
                        controller: controller,
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              tabs.length,
                              (i) => GestureDetector(
                                onTap: () {
                                  setState(() => currentIndex = i);
                                },
                                child: AnimatedContainer(
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: 100,
                                  duration: const Duration(milliseconds: 650),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                      width: 3,
                                      color: currentIndex == i
                                          ? Colors.red
                                          : Colors.transparent,
                                    )),
                                  ),
                                  child: Text(
                                    tabs[i],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: currentIndex == i
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(flex: 3, child: buildProducts(items, ref))
                    ],
                  ),
              error: (error, stackTrace) => const Scaffold(),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  )));
    });
  }

  ProductList buildProducts(List<ProductModel> i, WidgetRef ref) {
    final p = ref.read(productProvider);
    switch (currentIndex) {
      case 0:
        return ProductList(item: i);
      case 1:
        return ProductList(item: p.flowers(i));
      case 2:
        return ProductList(item: p.fruits(i));
      case 3:
        return ProductList(item: p.pizza(i));
      case 4:
        return ProductList(item: p.laptop(i));
      case 5:
        return ProductList(item: p.shoe(i));
      case 6:
        return ProductList(item: p.phone(i));
      case 7:
        return ProductList(item: p.shirts(i));

      default:
        return const ProductList();
    }
  }
}
