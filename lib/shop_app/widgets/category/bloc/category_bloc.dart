import 'package:bloc_pattern/shop_app/repositories/categories.dart';
import 'package:bloc_pattern/shop_app/widgets/product/bloc/product_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_events.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc({
    required this.categoryRepository,
  }) : super(const CategoryState()) {
    // on<GetCategories>(_mapGetCategoriesEventToState);
    // on<SelectCategory>(_mapSelectCategoryEventToState);
    on<GetCategories>(
        (event, emit) => _mapGetCategoriesEventToState(event, emit));
    on<SelectCategory>(
        (event, emit) => _mapSelectCategoryEventToState(event, emit));
  }
  final CategoriesRepository categoryRepository;

  void _mapGetCategoriesEventToState(
      GetCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      final categories = await categoryRepository.getAllCategories() ?? [];
      emit(
        state.copyWith(
          status: CategoryStatus.success,
          categories: categories,
        ),
      );

      if (categories.isNotEmpty) {
        add(SelectCategory(selectedCategory: categories[0], productBloc: event.productBloc));
      }
    } catch (error) {
      emit(state.copyWith(status: CategoryStatus.error));
    }
  }

  void _mapSelectCategoryEventToState(
      SelectCategory event, Emitter<CategoryState> emit) async {
     emit(
      state.copyWith(
        status: CategoryStatus.selected,
        selectedCategory: event.selectedCategory,
      ),
    );

    _getProductByCategort(event);
  }

  _getProductByCategort(SelectCategory event) {
    if (event.productBloc != null) {
      event.productBloc!
          .add(GetProductByCategory(category: event.selectedCategory));
    }
  }
}
