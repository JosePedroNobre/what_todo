import 'package:equatable/equatable.dart';
import 'package:what_todo/network/api_error.dart';
import 'package:what_todo/network/models/todo.dart';
import 'package:what_todo/todo_repository.dart';
import 'package:bloc/bloc.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository repository;
  TodoCubit(
    this.repository,
  ) : super(TodoInitial());

  void getTodoList() async {
    emit(TodoLoading());
    try {
      var response = await repository.getTodoList();
      emit(TodoLoaded(listOfTodo: response));
    } catch (e) {
      emit(TodoError(e is ApiError ? e : null));
    }
  }

  void addTodoItem(String title) {
    final newTodoItem = Todo(
      title: title,
      completed: false,
    );

    final currentItems = (state as TodoLoaded).listOfTodo;
    final updatedItems = [newTodoItem, ...currentItems];

    emit(
      TodoLoaded(
        listOfTodo: updatedItems,
      ),
    );
  }

  void deleteTodoItem(int index) {
    final currentItems = (state as TodoLoaded).listOfTodo;
    if (index < 0 || index >= currentItems.length) {
      return;
    }
    final updatedItems = List<Todo>.from(currentItems)..removeAt(index);
    emit(
      TodoLoaded(
        listOfTodo: updatedItems,
      ),
    );
  }

  void toggleTodoItem(int index) {
    final currentItems = (state as TodoLoaded).listOfTodo;
    if (index < 0 || index >= currentItems.length) {
      return;
    }
    final todoItem = currentItems[index];
    final updatedItem = todoItem.copyWith(completed: !todoItem.completed!);
    final updatedItems = List<Todo>.from(currentItems)..[index] = updatedItem;
    emit(TodoLoaded(listOfTodo: updatedItems));
  }
}
