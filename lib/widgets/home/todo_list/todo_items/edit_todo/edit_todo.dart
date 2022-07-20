import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_cubit.dart';
import 'package:todo_shp_loc_cubit/models/todo.dart';

class EditTodo extends StatelessWidget {
  final Todo todo;
  const EditTodo({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return GestureDetector(
      onTap: () {
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
      child: const Icon(
        Icons.edit,
        color: Color.fromARGB(255, 86, 144, 121),
      ),
    );
  }
}
