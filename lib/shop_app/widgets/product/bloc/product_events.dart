part of 'product_bloc.dart';

class ProductEvents{}

class GetProductByCategory extends ProductEvents{
  final String category;

  GetProductByCategory({required this.category});
}