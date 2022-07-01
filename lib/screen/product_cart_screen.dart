import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/services/firestore_service.dart';
import 'package:shoppy/widget/cart_item_list.dart';
import 'package:shoppy/widget/custom_button.dart';

import '../provider/product_provider.dart';

final cartFutureProvider = FutureProvider((ref) async {
  return ref.read(firestoreProvider).getProductsFromCart();
});

class ItemCartScreen extends StatelessWidget {
  const ItemCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
     // final n = ref.watch(firestoreProvider).getTotalPriceInCart();
      return Scaffold(
          appBar: AppBar(title: const Text('Cart')),
          body: SafeArea(
              child: ref.watch(cartFutureProvider).when(
                  data: (cart) => Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, i) =>
                                    CartItemList(model: cart[i])),
                          ),
                          CustomButton(
                            onPressed: () {},text: '5412',
                            //text: 'Check out \$${n.toStringAsFixed(1)}',
                          )
                        ],
                      ),
                  error: (error, stackTrace) => const Scaffold(),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ))));
    });
  }
}
