part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoError extends TodoState {
  final String error;

  TodoError(this.error);
}

final class TodoList extends TodoState {
  final List<TodoModel> items;

  TodoList(this.items);
}

