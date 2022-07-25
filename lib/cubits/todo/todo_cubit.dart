import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_state.dart';
import 'package:todo_shp_loc_cubit/models/todo.dart';

class TodoCubit extends Cubit<TodoState> {
  List<dynamic> todoList = [];
  final controller = TextEditingController();

  TodoCubit() : super(TodoLoadingState()) {
    loadData();
  }

  // @override
  // void onChange(Change<TodoState> change) {
  //   saveData();
  //   super.onChange(change);
  // }

  void removeTodo(Todo todo) {
    todoList.remove(todo);
    saveData();
    emit(TodoLoadedState(loadedTodo: todoList));
    if (todoList.isEmpty) {
      return emit(TodoEmptyState());
    }
  }

  void addTodo(Todo newTodo) {
    todoList.insert(0, newTodo);
    saveData();

    emit(TodoLoadedState(loadedTodo: todoList));
  }

  void updateTodo(Todo item, String title) {
    item.title = title;
    saveData();
    emit(TodoLoadedState(loadedTodo: todoList));
  }

  void toggleStatus(Todo todo) {
    todo.completed = !todo.completed;
    saveData();
    emit(TodoLoadedState(loadedTodo: todoList));
  }

  void loadData() async {
    try {
      emit(TodoLoadingState());

      Future.delayed(
        const Duration(seconds: 2),
        () async {
          final sharedPreferences = await SharedPreferences.getInstance();
          List<String> listString =
              sharedPreferences.getStringList('list') ?? [];
          if (listString.isNotEmpty) {
            todoList = listString
                .map((item) => Todo.fromJson(json.decode(item)))
                .toList();
          } else {
            return emit(TodoEmptyState());
          }
          emit(TodoLoadedState(loadedTodo: todoList));
        },
      );
    } catch (e) {
      emit(TodoErrorState());
    }
  }

  void saveData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    List<String> stringList =
        todoList.map((item) => json.encode(item.toJson())).toList();
    sharedPreferences.setStringList('list', stringList);
  }
}
