import 'package:flutter/material.dart';
import 'package:shoppy/widget/badge.dart';
import 'package:shoppy/widget/product_tab.dart';
import 'package:shoppy/widget/user_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(child: Userdrawer()),
        appBar: AppBar(
          title: const Text('Home'),
          actions: const [Badge()],
        ),
        body: const ProductTab());
  }
}
