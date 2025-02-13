import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<TodoEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        // Load JSON from local file
        final String jsonString =
            await rootBundle.loadString('assets/data.json');

        // Parse JSON
        final Map<String, dynamic> jsonData = jsonDecode(jsonString);
        final List<dynamic> todoJson = jsonData['todos'];

        // Convert JSON to TodoModel objects
        final List<TodoModel> todos =
            todoJson.map((todoJson) => TodoModel.fromMap(todoJson)).toList();
        // Emit the loaded state with todos
        return emit(TodoList(todos));
      } catch (e) {
        emit(TodoError('Failed to load todos: $e'));
        print(e);
      }
    });

    on<UpdateTodo>((event, emit) {
      if (state is TodoList) {
        final List<TodoModel> items = List.from((state as TodoList).items);
        final currentTodo = items[event.todoIndex];
        final TodoModel updatedTodo =
            currentTodo.copyWith(completed: !currentTodo.completed);
        items[event.todoIndex] = updatedTodo;
        emit(TodoList(items));
      }
    });

    on<SaveTodo>((event, emit) {
      final List<TodoModel> items = List.from((state as TodoList).items);

      final TodoModel todo = TodoModel.fromMap({
        'id': items.length + 1,
        'title': event.title,
        'description': event.description,
        'completed': false,
        'dueDate': '1-1-25'
      });
      emit(TodoList([...items, todo]));
    });
  }
}
