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
                  return ListTile(
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
                  );
                },
              );
            } else {}
            return Text('');
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-todo');
        },
        backgroundColor: Colors.teal,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
