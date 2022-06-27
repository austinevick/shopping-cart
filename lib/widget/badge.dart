import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/widget/product_tab.dart';

import '../constant.dart';
import '../provider/product_provider.dart';
import '../screen/product_cart_screen.dart';

class Badge extends StatelessWidget {
  const Badge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (ctx, ref, _) {
      final n = ref.watch(cartFutureProvider);
      return Stack(
        children: [
          IconButton(
              onPressed: () => push(context, const ItemCartScreen()),
              icon: const Icon(
                Icons.shopping_cart,
              )),
          Positioned(
              right: 3,
              top: 3,
              child: n.when(
                  data: (data) => data.isEmpty
                      ? const SizedBox.shrink()
                      : CircleAvatar(
                          radius: 8.6,
                          backgroundColor: primaryColor,
                          child: Text(
                            data.length.toString(),
                            style: style.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                  error: (error, trace) => const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink()))
        ],
      );
    });
  }
}
