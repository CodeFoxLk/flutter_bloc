import 'package:bloc/bloc.dart';
import 'package:bloc_pattern/shop_app/repositories/products.dart';

part 'product_events.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvents, ProductState> {
  ProductBloc({required this.productRepository}) : super(const ProductState()) {
    on<GetProductByCategory>(_getProductsByCategory);
  }

  final ProductRepository productRepository;

  void _getProductsByCategory(GetProductByCategory event, Emitter<ProductState> emit) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    try {
      final products = await productRepository.getAllCategories(event.category);
      emit(
        state.copyWith(products: products, productStatus: ProductStatus.success),
      );
    } catch (e) {
      emit(state.copyWith(productStatus: ProductStatus.error));
    }
  }
}
