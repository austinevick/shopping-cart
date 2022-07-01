import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/constant.dart';
import 'package:shoppy/screen/add_products_screen.dart';
import 'package:shoppy/screen/product_search_screen.dart';
import 'package:shoppy/services/firestore_service.dart';
import 'package:shoppy/widget/badge.dart';
import 'package:shoppy/widget/product_tab.dart';
import 'package:shoppy/widget/user_drawer.dart';

final userProvider =
    FutureProvider((ref) async => ref.read(firestoreProvider).getUserInfo());

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      return Scaffold(
        drawer: const Drawer(child: Userdrawer()),
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            const Badge(),
            IconButton(
                onPressed: () => push(context, const ProductSearchScreen()),
                icon: const Icon(Icons.search))
          ],
        ),
        body: const ProductTab(),
        floatingActionButton: ref.watch(userProvider).when(
            data: (data) => data.isAdmin == true
                ? FloatingActionButton(
                    backgroundColor: primaryColor,
                    onPressed: () => push(context, const AddProductsScreen()),
                    child: const Icon(Icons.add, color: Colors.white),
                  )
                : null,
            error: (error, trace) => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink()),
      );
    });
  }
}
