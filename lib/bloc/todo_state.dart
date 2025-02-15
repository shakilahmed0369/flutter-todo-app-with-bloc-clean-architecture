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
  final List<int> selectedItems;

  TodoList(this.items, {this.selectedItems = const []});

  TodoList copyWith({List<TodoModel>? items, List<int>? selectedItems}) {
    return TodoList(
      items ?? this.items,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
