import 'package:bloc_pattern/bloc-simple_app/bloc/bloc.dart';
import 'package:bloc_pattern/bloc-simple_app/bloc/events.dart';
import 'package:bloc_pattern/bloc-simple_app/bloc/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocApp extends StatelessWidget {
  const SimpleBlocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
          create: (context) => UserBloc(), child: const HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(LoadUserAction());
                },
                child: const Text("Load users")),
            Expanded(child:
                BlocBuilder<UserBloc, UserState?>(builder: (contxt, state) {
              return ListView.builder(
                  itemCount: state?.users.length ?? 0,
                  itemBuilder: (context, index) {
                    final user = state?.users[index];
                    if (user == null) return const SizedBox();
                    return ListTile(title: Text(user.name ?? ''));
                  });
            }))
          ],
        ),
      ),
    );
  }
}
