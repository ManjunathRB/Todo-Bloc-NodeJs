import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_nodejs/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({super.key});
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is TodoAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(state.message),
              ),
            );
            Navigator.pop(context);
          } else if (state is AddTodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error),
              ),
            );
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
            _addBtn(context),
          ]),
        ),
      ),
    );
  }

  Widget _addBtn(context) {
    return ElevatedButton(
        style: ButtonStyle(
            minimumSize: MaterialStatePropertyAll(
                Size(MediaQuery.of(context).size.width, 60))),
        onPressed: () {
          final message = _controller.text;
          BlocProvider.of<AddTodoCubit>(context).addTodo(message);
        },
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddingTodo) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return const Text("Add Todo");
          },
        ));
  }
}
