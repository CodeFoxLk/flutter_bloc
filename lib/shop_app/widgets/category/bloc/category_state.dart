part of 'category_bloc.dart';

enum CategoryStatus { initial, success, error, loading, selected }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isError => this == CategoryStatus.error;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSelected => this == CategoryStatus.selected;
}

class CategoryState{
  const CategoryState({
    this.status = CategoryStatus.initial,
    List<String>? categories,
    this.selectedCategory = '',
  })  : categories = categories ?? const [];
       

  final List<String> categories;
  final CategoryStatus status;
  final String selectedCategory;

  
  CategoryState copyWith({
    List<String>? categories,
    CategoryStatus? status,
    String? selectedCategory,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}