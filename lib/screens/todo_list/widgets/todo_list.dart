import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/cubit/todo_cubit.dart';
import 'package:what_todo/network/models/todo.dart';
import 'package:what_todo/screens/todo_list/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> listOfTodo;
  const TodoList({super.key, required this.listOfTodo});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return TodoItem(
            title: listOfTodo[index].title ?? '',
            isCompleted: listOfTodo[index].completed ?? false,
            onDelete: () {
              BlocProvider.of<TodoCubit>(context).deleteTodoItem(index);
            },
            onComplete: () {
              BlocProvider.of<TodoCubit>(context).toggleTodoItem(index);
            },
          );
        },
        childCount: listOfTodo.length,
      ),
    );
  }
}
