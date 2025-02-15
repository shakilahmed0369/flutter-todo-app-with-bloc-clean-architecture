import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(FetchTodo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "T O D O",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            if (state is TodoList) {
              print('selected todos');
              print(state.selectedItems);
            }
          },
          child: BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state is TodoLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.teal,
                  ),
                );
              }

              if (state is TodoList) {
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    final todo = state.items[index];
                    final isSelected = state.selectedItems.contains(index);

                    return ListTile(
                      tileColor: isSelected
                          ? const Color.fromARGB(67, 0, 150, 135)
                          : Colors.transparent,
                      title: todo.completed
                          ? Text(
                              todo.title,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            )
                          : Text(todo.title),
                      subtitle: todo.completed
                          ? Text(
                              todo.description,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            )
                          : Text(todo.description),
                      trailing: todo.completed
                          ? Icon(
                              Icons.check_circle,
                              color: Colors.teal,
                            )
                          : Icon(
                              Icons.pending_actions_rounded,
                              color: Colors.orange,
                            ),
                      onTap: () {
                        context.read<TodoBloc>().add(UpdateTodo(index));
                      },
                      onLongPress: () {
                        context.read<TodoBloc>().add(SelectTodo(index));
                      },
                    );
                  },
                );
              } else {}
              return Text('');
            },
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoList) {
            if (state.selectedItems.isEmpty) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add-todo');
                },
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              );
            } else {
              return FloatingActionButton(
                onPressed: () {
                  context.read<TodoBloc>().add(DeleteSelectedTodos());
                },
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              );
            }
          }
          return SizedBox();
        },
      ),
    );
  }
}
