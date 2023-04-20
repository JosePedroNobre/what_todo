import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/cubit/todo_cubit.dart';
import 'package:what_todo/network/api_service.dart';
import 'package:what_todo/network/error_helper.dart';
import 'package:what_todo/route_generator.dart';
import 'package:what_todo/screens/todo_list/todo_list_screen.dart';
import 'package:what_todo/todo_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ErrorHelper.errorStream = StreamController<String>.broadcast();
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TodoRepository>(
          create: (context) => TodoRepository(ApiService.shared),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<TodoCubit>(
          create: (context) => TodoCubit(
            context.read<TodoRepository>(),
          ),
        ),
      ], child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(),
      home: const TodoListScreen(),
    );
  }
}
