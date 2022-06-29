import 'package:flutter/material.dart';
import 'package:shoppy/constant.dart';
import 'package:shoppy/model/product_model.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({Key? key}) : super(key: key);

  @override
  State<ProductSearchScreen> createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  List<ProductModel> searchedItem = [];
  final ctr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
                child: SizedBox(
                  height: 60,
                  child: Material(
                    elevation: 3,
                    color: Colors.black54,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.keyboard_backspace,
                            )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: TextField(
                          controller: ctr,
                          autofocus: true,
                          onChanged: (val) => setState(() {
                            if (val.isNotEmpty) {
                              Future.delayed(const Duration(seconds: 2), () {
                                searchedItem = products
                                    .where((element) => element.name!
                                        .contains(val.toLowerCase()))
                                    .toList();
                              });
                            }
                          }),
                          style: style.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w700),
                          decoration: const InputDecoration(
                              hintText: 'Search here',
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ))
                      ],
                    ),
                  ),
                ),
                preferredSize: const Size(65, 65)),
            body: ctr.text.isEmpty
                ? Container()
                : ListView(
                    children: List.generate(
                        searchedItem.length,
                        (i) => ListTile(
                              title: Row(
                                children: [
                                  Text(
                                    '${searchedItem[i].name!} ',
                                    style: style.copyWith(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text('in ${searchedItem[i].category}'),
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            )))));
  }
}
