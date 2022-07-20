import 'package:easy_localization/easy_localization.dart';
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

  Future<void> showCreateDialog(BuildContext context) {
    void addTodo() {
      String inputValue = _todosCubit.controller.text;
      if (inputValue.isNotEmpty) {
        _todosCubit.addTodo(
          Todo(
            title: inputValue,
            completed: false,
          ),
        );
      }
      Navigator.of(context).pop();
    }

    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr('creat_todo')),
        content: TextField(
          onEditingComplete: () => addTodo(),
          controller: _todosCubit.controller,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => addTodo(),
            child: const Text("Ok"),
          ),
        ],
      ),
    );
  }

  void locale(String languageSubtype, String countrySubtype) {
    context.setLocale(Locale(languageSubtype, countrySubtype));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final lightTheme = themeCubit.lightTheme;

    Color themeStyle = !lightTheme
        ? const Color.fromARGB(255, 77, 81, 85)
        : const Color.fromARGB(255, 44, 181, 215);

    return BlocProvider.value(
      value: _todosCubit,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Text(
                  tr('light_theme'),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 230, 206, 206),
                    fontFamily: 'SF Pro Text',
                  ),
                ),
                const SizedBox(width: 10),
                Switch(
                  activeColor: Colors.blue[200],
                  value: lightTheme,
                  onChanged: (_) => themeCubit.themeChanged(),
                ),
              ],
            ),
          ],
          title: Text(tr('app_bar_title').toUpperCase()),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    ButtonStyle buttonStyle = ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(themeStyle),
                    );
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.end,
                      title: Text(tr('language')),
                      actions: [
                        TextButton(
                          style: buttonStyle,
                          onPressed: () => locale('ru', 'RU'),
                          child: const Text(
                            'Русский',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          style: buttonStyle,
                          onPressed: () => locale('ky', 'KG'),
                          child: const Text('Кыргызча'),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          style: buttonStyle,
                          onPressed: () => locale('en', 'US'),
                          child: const Text('English'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Color.fromARGB(255, 86, 144, 121),
                    ),
                    const SizedBox(width: 10),
                    Text(tr('language'))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(child: TodoLIst()),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeStyle,
          onPressed: () async {
            _todosCubit.controller.text = '';
            return await showCreateDialog(context);
          },
          child: Icon(
            Icons.add,
            color: Colors.blue[50],
          ),
        ),
      ),
    );
  }
}
