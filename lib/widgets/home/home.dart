import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_shp_loc_cubit/cubits/theme/theme_cubit.dart';
import 'package:todo_shp_loc_cubit/cubits/todo/todo_cubit.dart';
import 'package:todo_shp_loc_cubit/models/todo.dart';
import 'package:todo_shp_loc_cubit/widgets/home/todo_list/todo_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final _todosCubit = TodoCubit();

  @override
  void dispose() {
    _todosCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();

    return BlocProvider.value(
      value: _todosCubit,
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: DropdownButton<Locale>(
              value: context.locale,
              isDense: true,
              icon: const SizedBox.shrink(),
              iconEnabledColor: Colors.white,
              underline: const SizedBox.shrink(),
              onChanged: (locale) {
                context.setLocale(locale ?? context.locale);
              },
              items: const [
                DropdownMenuItem(value: Locale('en', 'US'), child: Text('EN')),
                DropdownMenuItem(value: Locale('ky', 'KG'), child: Text('KG')),
                DropdownMenuItem(value: Locale('ru', 'RU'), child: Text('RU'))
              ],
              selectedItemBuilder: (context) => [
                const Text('EN', style: TextStyle(color: Colors.white)),
                const Text('KG', style: TextStyle(color: Colors.white)),
                const Text('RU', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: themeCubit.toggle,
              icon: Icon(themeCubit.state.brightness == Brightness.light
                  ? Icons.light_mode
                  : Icons.dark_mode),
            ),
          ],
          title: Text(tr('app_bar_title').toUpperCase()),
        ),
        body: const SizedBox(child: Expanded(child: TodoLIst())),
        floatingActionButton: _FloatingActionButton(todosCubit: _todosCubit),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({
    Key? key,
    required TodoCubit todosCubit,
  })  : _todosCubit = todosCubit,
        super(key: key);

  final TodoCubit _todosCubit;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 101, 118, 125),
      onPressed: () async {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            final todoController = TextEditingController();
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Material(
                color: Colors.transparent,
                child: CupertinoAlertDialog(
                  title: Text(tr('creat_todo')),
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
                        _todosCubit.addTodo(
                          Todo(
                            title: todoController.text,
                            completed: false,
                          ),
                        );
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
      child: const Icon(Icons.add),
    );
  }
}
