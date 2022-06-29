import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shoppy/provider/product_provider.dart';
import 'package:shoppy/screen/product_cart_screen.dart';
import 'package:shoppy/widget/custom_loader.dart';

import '../constant.dart';
import '../model/product_model.dart';
import '../screen/product_detail_screen.dart';

class CartItemList extends StatefulWidget {
  final ProductModel? model;
  const CartItemList({Key? key, this.model}) : super(key: key);

  @override
  State<CartItemList> createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  bool isLoading = false;

  Future<void> removeProductFromCart(WidgetRef ref) async {
    try {
      setState(() => isLoading = true);
      await Future.delayed(
          const Duration(seconds: 5),
          (() => ref.read(productProvider).removeProductFromCart(
                widget.model!,
              )));
      ref.refresh(cartFutureProvider);
      setState(() => isLoading = false);
    } catch (e) {
      setState(() => isLoading = false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final n = ref.read(productProvider);
      return MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => showMaterialModalBottomSheet(
            expand: true,
            context: context,
            builder: (ctx) => ItemDetailScreen(item: widget.model)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  height: 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(widget.model!.image!),
                      )),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.model!.name!,
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        " (${widget.model!.quantity.toString()}) ",
                        style: style.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$" + widget.model!.price!.toStringAsFixed(1),
                    style: style.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 110,
                        child: OutlinedButton(
                            onPressed: () => removeProductFromCart(ref),
                            child: CustomLoader(
                                color: primaryColor,
                                isLoading: isLoading,
                                text: 'Remove')),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        width: 110,
                        child: OutlinedButton(
                            onPressed: () {}, child: const Text('Buy')),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
