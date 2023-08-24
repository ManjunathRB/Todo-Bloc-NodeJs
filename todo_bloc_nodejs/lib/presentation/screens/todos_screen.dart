import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_nodejs/constants.dart';
import 'package:todo_bloc_nodejs/cubit/todos_cubit.dart';
import 'package:todo_bloc_nodejs/data/todo_model.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodosCubit>(context).fetchTodos();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos Bloc"),
        actions: [
          InkWell(
              onTap: () => Navigator.pushNamed(context, ADD_TODO_ROUTE),
              child: const Icon(Icons.add)),
          const SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state is! TodosLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = state.todos;
          return SingleChildScrollView(
            child: Column(
              children: todos.map((e) => _todo(e, context)).toList(),
            ),
          );
        },
      ),
    );
  }

  Widget _todo(Todos todo, context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, EDIT_TODO_ROUTE, arguments: todo),
      child: Dismissible(
        key: Key("${todo.id}"),
        background: Container(
          color: Colors.indigo,
        ),
        confirmDismiss: (_) async {
          BlocProvider.of<TodosCubit>(context).changeCompletion(todo);
          return false;
        },
        child: _todoTile(context, todo),
      ),
    );
  }

  Widget _todoTile(context, Todos todo) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(todo.todo), Text(todo.date)],
        ),
        _completionIndicator(todo),
      ]),
    );
  }

  Widget _completionIndicator(Todos todo) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 5,
          color: todo.isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
