import 'package:bloc_pattern/shop_app/widgets/category/category_widget.dart';
import 'package:bloc_pattern/shop_app/widgets/product/products_list.dart';
import 'package:flutter/material.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Categories(),
        Expanded(child: ProductList())
      ],
    );
  }
}