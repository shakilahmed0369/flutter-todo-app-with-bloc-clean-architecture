part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class FetchTodo extends TodoEvent {}

final class UpdateTodo extends TodoEvent {
  final int todoIndex;

  UpdateTodo(this.todoIndex);
}

final class SaveTodo extends TodoEvent {
  final String title;
  final String description;

  SaveTodo({required this.title, required this.description});
  
}
