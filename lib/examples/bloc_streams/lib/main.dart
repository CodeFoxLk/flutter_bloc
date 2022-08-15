import 'package:bloc_streams/bloc.dart';
import 'package:bloc_streams/cities_stream.dart';
import 'package:bloc_streams/events.dart';
import 'package:bloc_streams/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create:(context) => AppBloc(),
        child: const _MyHomePage()),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  const _MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: state.cities.map((e) => Text('   $e,   ')).toList(),
              ),
              if(state.onDoneMessage != null)
              Text(state.onDoneMessage!, style: const TextStyle(fontWeight: FontWeight.bold, height: 5),)
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.start),
        onPressed: () {
          context.read<AppBloc>().add(FetchingCitiesEvent(CitiesStream()));
        },
      ),
    );
  }
}
