import 'package:flutter/material.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_cubit.dart';
import 'package:todo_shp_loc_cubit/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteTodo extends StatelessWidget {
  const DeleteTodo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return GestureDetector(
      onTap: () => todoCubit.removeTodo(todo),
      child: const Icon(
        Icons.delete,
        color: Color.fromARGB(255, 96, 13, 13),
      ),
    );
  }
}
