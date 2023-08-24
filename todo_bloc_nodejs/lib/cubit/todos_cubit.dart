import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_nodejs/data/repository.dart';
import 'package:todo_bloc_nodejs/data/todo_model.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final Repository repository;
  TodosCubit({required this.repository}) : super(TodosInitial());

  void fetchTodos() async {
    await Future.delayed(const Duration(seconds: 1));
    repository.fetchTodos().then((todos) {
      emit(TodosLoaded(todos: todos));
    });
  }

  void changeCompletion(Todos todo) {
    repository.changeCompletion(!todo.isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = !todo.isCompleted;
        updateTodoList();
      }
    });
  }

  void updateTodoList() {
    final currrentstate = state;
    if (currrentstate is TodosLoaded) {
      emit(TodosLoaded(todos: currrentstate.todos));
    }
  }

  void addTodo(Todos todo) {
    final currrentstate = state;
    if (currrentstate is TodosLoaded) {
      final todosList = currrentstate.todos;
      todosList.add(todo);
      emit(TodosLoaded(todos: todosList));
    }
  }

  void deleteTodo(Todos todo) {
    final currrentstate = state;
    if (currrentstate is TodosLoaded) {
      final todosList = currrentstate.todos
          .where((element) => element.id != todo.id)
          .toList();

      emit(TodosLoaded(todos: todosList));
    }
  }
}
