import 'package:bloc_pattern/shop_app/repositories/products.dart';
import 'package:bloc_pattern/shop_app/widgets/product/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.productStatus.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
           padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              Product product = state.products[index];
              return ListTile(
                leading: product.image == null
                    ? const SizedBox()
                    : Image.network(
                        product.image!,
                        width: 60,
                        height: 60,
                      ),
                title: Text(product.title ?? ' '),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: state.products.length);
      },
    );
  }
}
