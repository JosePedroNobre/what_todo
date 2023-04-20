import 'dart:async';
import 'package:what_todo/cubit/todo_cubit.dart';
import 'package:what_todo/network/error_helper.dart';
import 'package:what_todo/network/models/todo.dart';
import 'package:what_todo/todo_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'mocks/mock_assets.dart';
import 'todo_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<TodoRepository>(onMissingStub: OnMissingStub.throwException),
])
void main() {
  late TodoRepository repository;
  late TodoCubit todoCubit;

  ErrorHelper.errorStream = StreamController<String>.broadcast();

  setUp(() async {
    repository = MockTodoRepository();

    // Load the stub and wait for it to complete before configuring the mock repository
    final value = await loadStub('todo_success');
    when(repository.getTodoList()).thenAnswer((_) => Future.value(value));

    todoCubit = TodoCubit(repository);
  });

  blocTest<TodoCubit, TodoState>(
    'Get Todos for user',
    build: () => todoCubit,
    act: (bloc) => bloc.getTodoList(),
    expect: () => [
      TodoLoading(),
      TodoLoaded(listOfTodo: [Todo(title: 'TODO1', completed: false)]),
    ],
  );
}
