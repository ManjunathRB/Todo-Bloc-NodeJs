import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_nodejs/cubit/add_todo_cubit.dart';
import 'package:todo_bloc_nodejs/cubit/edit_todo_cubit.dart';
import 'package:todo_bloc_nodejs/cubit/todos_cubit.dart';
import 'package:todo_bloc_nodejs/data/network_service.dart';
import 'package:todo_bloc_nodejs/data/repository.dart';
import 'package:todo_bloc_nodejs/data/todo_model.dart';
import 'package:todo_bloc_nodejs/presentation/screens/add_todo_screen.dart';
import 'package:todo_bloc_nodejs/presentation/screens/edit_todo_screen.dart';
import 'package:todo_bloc_nodejs/presentation/screens/todos_screen.dart';

import '../constants.dart';

class AppRouter {
  Repository? repository;
  TodosCubit? todosCubit;

  AppRouter() {
    repository = Repository(networkService: NetworkService());
    todosCubit = TodosCubit(repository: repository!);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: todosCubit!,
                  child: const TodosScreen(),
                ));
      case EDIT_TODO_ROUTE:
        final todo = settings.arguments as Todos;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => EditTodoCubit(repository!, todosCubit!),
                  child: EditTodoScreen(todo: todo),
                ));
      case ADD_TODO_ROUTE:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => AddTodoCubit(repository!, todosCubit!),
                  child: AddTodoScreen(),
                ));
      default:
        return null;
    }
  }
}
