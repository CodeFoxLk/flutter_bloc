part of 'category_bloc.dart';

abstract class CategoryEvent{
  ProductBloc? productBloc;
  CategoryEvent({this.productBloc});
}

class GetCategories extends CategoryEvent {
  @override
  GetCategories({super.productBloc});
}

class SelectCategory extends CategoryEvent {
  SelectCategory({
    required this.selectedCategory,
    super.productBloc, 
  });
  final String selectedCategory;
}