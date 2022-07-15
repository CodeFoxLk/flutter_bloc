part of 'product_bloc.dart';

enum ProductStatus { initial, success, error, loading, selected }

extension ProductStatusX on ProductStatus {
  bool get isInitial => this == ProductStatus.initial;
  bool get isSuccess => this == ProductStatus.success;
  bool get isError => this == ProductStatus.error;
  bool get isLoading => this == ProductStatus.loading;
  bool get isSelected => this == ProductStatus.selected;
}

class ProductState {
  const ProductState(
      {List<Product>? products,
      this.category = '',
      this.productStatus = ProductStatus.initial})
      : products = products ?? const [];

  final List<Product> products;
  final String category;
  final ProductStatus productStatus;

  ProductState copyWith(
      {List<Product>? products,
      String? category,
      ProductStatus? productStatus}) {
    return ProductState(
        products: products ?? this.products,
        category: category ?? this.category,
        productStatus: productStatus ?? this.productStatus);
  }
}
