import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_nodejs/cubit/todos_cubit.dart';
import 'package:todo_bloc_nodejs/data/repository.dart';
part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;
  AddTodoCubit(this.repository, this.todosCubit) : super(AddTodoInitial());

  void addTodo(String message) async {
    if (message.isEmpty) {
      emit(AddTodoError("Todo is Empty"));
      return;
    }
    emit(AddingTodo());
    await Future.delayed(const Duration(seconds: 1));
    repository.addTodo(message).then((todo) {
      if (todo != null) {
        todosCubit.addTodo(todo);
        emit(TodoAdded());
      }
    });
  }
}
