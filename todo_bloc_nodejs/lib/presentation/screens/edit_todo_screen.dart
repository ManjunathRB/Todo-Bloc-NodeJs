import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_nodejs/cubit/edit_todo_cubit.dart';
import 'package:todo_bloc_nodejs/data/todo_model.dart';

class EditTodoScreen extends StatelessWidget {
  EditTodoScreen({super.key, required this.todo});
  final Todos todo;
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _controller.text = todo.todo;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Todo"),
        actions: [
          InkWell(
            onTap: () {
              BlocProvider.of<EditTodoCubit>(context).deleteTodo(todo);
            },
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: BlocListener<EditTodoCubit, EditTodoState>(
        listener: (context, state) {
          if (state is TodoDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.message),
              ),
            );
            Navigator.pop(context);
          } else if (state is TodoEdited) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.message),
              ),
            );
            Navigator.pop(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              autofocus: true,
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: "Enter Todo Message..."),
            ),
            const SizedBox(
              height: 20,
            ),
            _updateBtn(context),
          ]),
        ),
      ),
    );
  }

  Widget _updateBtn(context) {
    return ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(
                Size(MediaQuery.of(context).size.width, 60))),
        onPressed: () {
          final message = _controller.text;
          BlocProvider.of<EditTodoCubit>(context).updateTodo(todo, message);
        },
        child: const Text("Add Todo"));
  }
}
