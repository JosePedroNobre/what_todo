part of 'todo_cubit.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> listOfTodo;

  const TodoLoaded({
    required this.listOfTodo,
  });

  @override
  List<Object?> get props => [listOfTodo];
}

class TodoError extends TodoState {
  final ApiError? error;

  const TodoError(this.error);

  @override
  List<Object?> get props => [error];
}
