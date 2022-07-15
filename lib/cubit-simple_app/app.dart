import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math show Random;

class RandomNamePicker extends StatelessWidget {
  const RandomNamePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

const names = <String>['foo', 'bar', 'baz'];

//list is an Iterable. so we can create a custom method to do somthing for Iterables which also, works with a list
extension RandomElement<T> on Iterable<T> {
  T pickRandom() => elementAt(math.Random().nextInt(length));
}

//Cubit
class NamesCubit extends Cubit<String?> {
  NamesCubit() : super('null');
  void pickName() => emit(names.pickRandom());
}

//Screen
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NamesCubit namesCubit;

  @override
  void initState() {
    namesCubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    namesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  namesCubit.pickName();
                },
                child: const Text("Pick random name")),
            StreamBuilder<String?>(
                stream: namesCubit.stream,
                builder: (context, snapShot) {
                  final ConnectionState status = snapShot.connectionState;
                  switch (status) {
                    case ConnectionState.active:
                      return Text(snapShot.data ?? '');
                    
                    case ConnectionState.waiting:
                      return const Text(' The name will be show here ');
                   
                    default:
                      return const SizedBox();
                  }
                 
                }),
          ],
        ),
      ),
    );
  }
}

