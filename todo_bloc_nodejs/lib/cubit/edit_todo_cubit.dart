import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_nodejs/cubit/todos_cubit.dart';
import 'package:todo_bloc_nodejs/data/repository.dart';
import 'package:todo_bloc_nodejs/data/todo_model.dart';

part 'edit_todo_state.dart';

class EditTodoCubit extends Cubit<EditTodoState> {
  final Repository repository;
  final TodosCubit todosCubit;
  EditTodoCubit(this.repository, this.todosCubit) : super(EditTodoInitial());

  void updateTodo(Todos todo, String message) {
    if (message.isEmpty) {
      emit(EditTodoError("Message is Empty"));
    }
    repository.updateTodo(message, todo.id).then((isEdited) {
      if (isEdited) {
        todo.todo = message;
        todosCubit.updateTodoList();
        emit(TodoEdited());
      }
    });
  }

  void deleteTodo(Todos todo) {
    repository.deleteTodo(todo.id).then((isDeleted) {
      if (isDeleted) {
        todosCubit.deleteTodo(todo);
        emit(TodoDeleted());
      }
    });
  }
}
