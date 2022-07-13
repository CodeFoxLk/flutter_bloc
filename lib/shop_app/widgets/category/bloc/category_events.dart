part of 'category_bloc.dart';

class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategories extends CategoryEvent {}

class SelectCategory extends CategoryEvent {
  SelectCategory({
    required this.selectedCategory,
  });
  final String selectedCategory;

  @override
  List<Object?> get props => [selectedCategory];
}