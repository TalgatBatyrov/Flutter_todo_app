import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
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
    final theme = context.read<ThemeCubit>().state.brightness;
    return GestureDetector(
      onDoubleTap: () {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            final todoController = TextEditingController();
            todoController.text = todo.title;
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Material(
                color: Colors.transparent,
                child: CupertinoAlertDialog(
                  title: Text(tr('edit_todo')),
                  content: TextField(
                    controller: todoController,
                    autofocus: true,
                  ),
                  actions: [
                    CupertinoDialogAction(
                      child: Text(tr('cancel')),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CupertinoDialogAction(
                      child: Text(tr('save')),
                      onPressed: () {
                        if (todoController.text.isEmpty) {
                          Navigator.pop(context);
                          return;
                        }
                        todoCubit.updateTodo(todo, todoController.text);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Text(
        todo.title,
        style: TextStyle(
          fontSize: 16.0,
          fontFamily: 'SF Pro Text',
          color: todo.completed && theme == Brightness.light
              ? Colors.grey[500]
              : const Color.fromARGB(255, 86, 81, 81),
          decoration: todo.completed ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
