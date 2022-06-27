import 'package:entry/entry.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shoppy/constant.dart';
import 'package:shoppy/model/product_model.dart';
import 'package:shoppy/screen/product_detail_screen.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel>? item;
  const ProductList({Key? key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (ctx, i) => MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => showMaterialModalBottomSheet(
            expand: true,
            context: context,
            builder: (ctx) => ItemDetailScreen(item: item![i])),
        child: Entry.all(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(item![i].image!),
                  )),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      item![i].name!,
                      style: style.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$' + item![i].price!.toString(),
                      style: style.copyWith(
                        fontSize: 15,
                        color: primaryColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
              ),
            ),
          ),
        ),
      ),
      itemCount: item!.length,
    );
  }
}
