import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_cubit.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_state.dart';
import 'package:todo_shp_loc_cubit/widgets/home/todo_list/todo_items/todo_items.dart';
import 'package:todo_shp_loc_cubit/widgets/states_widgets/loading.dart';
import 'package:todo_shp_loc_cubit/widgets/states_widgets/empty.dart';
import 'package:todo_shp_loc_cubit/widgets/states_widgets/error.dart';

class TodoLIst extends StatelessWidget {
  const TodoLIst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        if (state is TodoEmptyState) {
          return const Empty();
        }
        if (state is TodoLoadingState) {
          return const Loading();
        }
        if (state is TodoErrorState) {
          return const Error();
        }
        if (state is TodoLoadedState) {
          return ListView.builder(
            itemCount: state.loadedTodo.length,
            itemBuilder: (_, index) {
              var todo = state.loadedTodo[index];
              return Container(
                key: ValueKey('TodoItem__$todo'),
                // color: index.isEven
                // ? const Color.fromARGB(99, 221, 222, 197)
                // : const Color.fromARGB(98, 181, 181, 178),
                child: TodoItems(todo: todo),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
