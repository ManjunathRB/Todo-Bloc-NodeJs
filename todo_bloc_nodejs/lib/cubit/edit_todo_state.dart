part of 'edit_todo_cubit.dart';

@immutable
abstract class EditTodoState {}

class EditTodoInitial extends EditTodoState {}

class EditTodoError extends EditTodoState {
  final String error;

  EditTodoError(this.error);
}

class TodoEdited extends EditTodoState {
  final String message = "Todo Edited..";
}

class TodoDeleted extends EditTodoState {
  final String message = "Todo Deleted..";
}
