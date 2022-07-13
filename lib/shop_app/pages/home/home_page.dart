import 'package:bloc_pattern/shop_app/repositories/categories.dart';
import 'package:bloc_pattern/shop_app/widgets/category/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern/shop_app/pages/home/home_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RepositoryProvider(
          create: (context) => CategoriesRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<CategoryBloc>(
                create: (context) => CategoryBloc(
                  categoryRepository: context.read<CategoriesRepository>(),
                )..add(
                    GetCategories(),
                  ),
              ),
            ],
            child: const HomeLayout(),
          ),
        ),
      ),
    );
  }
}
