import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/model/cart_model.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/provider/product_provider.dart';
import 'package:shoppy/screen/product_cart_screen.dart';
import 'package:shoppy/widget/custom_button.dart';
import 'package:shoppy/widget/custom_loader.dart';

import '../constant.dart';

class ItemDetailScreen extends StatefulWidget {
  final ProductModel? item;
  const ItemDetailScreen({Key? key, this.item}) : super(key: key);

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int quantity = 1;
  num? get cost => widget.item!.price! * quantity;

  int currentIndex = 0;

  bool isLoading = false;

  Future<void> addToCart(WidgetRef ref) async {
    try {
      setState(() => isLoading = true);
      await Future.delayed(
          const Duration(seconds: 3),
          (() => ref.read(productProvider).addProductToCart(ProductModel(
              name: widget.item!.name,
              id: widget.item!.id,
              image: widget.item!.image,
              quantity: quantity,
              price: cost))));
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
      return Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 450,
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.item!.image!),
                  )),
                ),
              ),
              Positioned(
                top: 25,
                left: 16,
                child: CircleAvatar(
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.keyboard_backspace)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('\$' + cost!.toStringAsFixed(1),
                    style: style.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 20)),
                const Spacer(),
                Text(
                  widget.item!.name!,
                  style:
                      style.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Spacer(flex: 2)
              ],
            ),
          ),
          const SizedBox(height: 12),
          n.isAlreadyInCart(widget.item!.id!)
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (quantity <= 1) return;
                              quantity--;
                            });
                          },
                          icon: const Icon(Icons.remove)),
                    ),
                    Text(
                      quantity.toString(),
                      style: style.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: primaryColor),
                    ),
                    CircleAvatar(
                      radius: 25,
                      child: IconButton(
                          onPressed: () => setState(() => quantity++),
                          icon: const Icon(Icons.add)),
                    )
                  ],
                ),
          const Spacer(),
          CustomButton(
            color: n.isAlreadyInCart(widget.item!.id!)
                ? Colors.green
                : primaryColor,
            child: CustomLoader(
              isLoading: isLoading,
              text: !n.isAlreadyInCart(widget.item!.id!)
                  ? 'Add to Cart'
                  : 'Go to Cart',
            ),
            onPressed: () {
              if (n.isAlreadyInCart(widget.item!.id!)) {
                Navigator.of(context).pop();
                push(context, const ItemCartScreen());
              } else {
                addToCart(ref);
              }
            },
          ),
          CustomButton(
            text: 'Order now',
            onPressed: () {},
          ),
        ],
      );
    });
  }
}
