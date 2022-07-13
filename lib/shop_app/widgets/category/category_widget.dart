import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/category_bloc.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<CategoryBloc, CategoryState>(
          buildWhen: (previous, current) => current.status.isSuccess,
          builder: (context, state) {
            return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.read<CategoryBloc>().add(SelectCategory(selectedCategory: state.categories[index]));
                    },
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                        //  buildWhen: (previous, current) => state.categories[index] == current.selectedCategory,
                        builder: (context, selectedState) {
                      final bool isSelected = state.categories[index] == selectedState.selectedCategory;
                      return Ink(
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color:
                                isSelected ? Colors.amber : Colors.blue[900]),
                        child: Text(
                          state.categories[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                  );
                },
                separatorBuilder: (c, i) => const SizedBox(width: 10),
                itemCount: state.categories.length);
          }),
    );
  }
}
