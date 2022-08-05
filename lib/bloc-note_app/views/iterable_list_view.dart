import 'package:flutter/material.dart';

extension ToListView<T> on Iterable{
  Widget toListView() =>  IterableListView(iterable: this);
}

class IterableListView<T> extends StatelessWidget {
  const IterableListView({Key? key, required this.iterable}) : super(key: key);

  final Iterable<T> iterable;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          ListTile(title: Text(iterable.elementAt(index).toString())),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: iterable.length,
    );
  }
}
