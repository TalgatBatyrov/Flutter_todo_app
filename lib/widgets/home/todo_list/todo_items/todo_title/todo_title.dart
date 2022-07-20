import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_shp_loc_cubit/cubits/theme/theme_cubit.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_cubit.dart';
import 'package:todo_shp_loc_cubit/models/todo.dart';

class TodoTitle extends StatelessWidget {
  final Todo todo;
  const TodoTitle({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final lightTheme = context.read<ThemeCubit>().lightTheme;
    return GestureDetector(
      onDoubleTap: () {
        void editTodo() {
          String inputValue = todoCubit.controller.text;
          if (inputValue.isNotEmpty) {
            todoCubit.updateTodo(todo, inputValue);
          }
          Navigator.of(context).pop();
        }

        showDialog(
          context: context,
          builder: (ctx) {
            todoCubit.controller.text = todo.title;
            return AlertDialog(
              title: Text(tr('edit_todo')),
              content: TextField(
                onEditingComplete: () => editTodo(),
                controller: todoCubit.controller,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => editTodo(),
                  child: const Text("Ok"),
                ),
              ],
            );
          },
        );
      },
      child: Text(
        todo.title,
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: 'SF Pro Text',
          color: todo.completed && lightTheme
              ? Colors.grey[500]
              : const Color.fromARGB(255, 86, 81, 81),
          decoration: todo.completed ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
