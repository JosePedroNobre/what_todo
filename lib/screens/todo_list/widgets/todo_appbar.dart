import 'package:flutter/material.dart';

class TodoAppBar extends StatelessWidget {
  final String title;
  const TodoAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      centerTitle: true,
      floating: true,
    );
  }
}
