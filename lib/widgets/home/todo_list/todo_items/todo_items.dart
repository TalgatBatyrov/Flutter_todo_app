import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_shp_loc_cubit/cubits/theme/theme_cubit.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_cubit.dart';
import 'package:todo_shp_loc_cubit/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_shp_loc_cubit/widgets/home/todo_list/todo_items/todo_title/todo_title.dart';

class TodoItems extends StatelessWidget {
  const TodoItems({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final themeCubit = context.watch<ThemeCubit>();
    var lightTheme = themeCubit.lightTheme;
    return Slidable(
        key: ValueKey(todo),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible:
              DismissiblePane(onDismissed: () => todoCubit.removeTodo(todo)),
          children: [
            SlidableAction(
              onPressed: (BuildContext context) => todoCubit.removeTodo(todo),
              backgroundColor: const Color.fromARGB(255, 238, 133, 133),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: CheckboxListTile(
          side: lightTheme
              ? const BorderSide(
                  color: Color.fromARGB(132, 105, 101, 101), width: 1)
              : const BorderSide(color: Colors.white, width: double.infinity),
          checkboxShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          controlAffinity: ListTileControlAffinity.leading,
          title: TodoTitle(todo: todo),
          activeColor: const Color.fromARGB(255, 14, 15, 15),
          value: todo.completed,
          onChanged: (_) => todoCubit.toggleStatus(todo),
        ));
  }
}
