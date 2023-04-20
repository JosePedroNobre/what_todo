import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/cubit/todo_cubit.dart';
import 'package:what_todo/network/models/todo.dart';
import 'package:what_todo/screens/todo_list/widgets/todo_appbar.dart';
import 'package:what_todo/screens/todo_list/widgets/todo_creation_fab.dart';
import 'package:what_todo/screens/todo_list/widgets/todo_list.dart';

class TodoListScreen extends StatefulWidget {
  static const route = '/todo_list_screen';

  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> listOfTodos = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButton: const TodoCreationFAB(),
      backgroundColor: Colors.white,
      body: BlocConsumer<TodoCubit, TodoState>(
        bloc: context.read<TodoCubit>()..getTodoList(),
        listenWhen: (previous, current) => current is TodoError,
        buildWhen: (previous, current) => current is TodoLoading || current is TodoLoaded || current is TodoError,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            listOfTodos = state.listOfTodo;
            return CustomScrollView(
              slivers: [const TodoAppBar(title: 'My TODOs'), TodoList(listOfTodo: state.listOfTodo)],
            );
          }
          return const Text("Error");
        },
      ),
    ));
  }
}
