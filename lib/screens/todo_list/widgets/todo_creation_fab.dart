import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:what_todo/cubit/todo_cubit.dart';

class TodoCreationFAB extends StatelessWidget {
  const TodoCreationFAB({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Create Todo'),
              content: TextField(
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Todo',
                ),
                onSubmitted: (String value) {
                  BlocProvider.of<TodoCubit>(context).addTodoItem(textEditingController.text);

                  // Close the dialog
                  Navigator.pop(context);
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<TodoCubit>(context).addTodoItem(textEditingController.text);
                    // Close the dialog
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
