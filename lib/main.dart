import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_shp_loc_cubit/cubits/theme/theme_cubit.dart';
import 'package:todo_shp_loc_cubit/cubits/theme/theme_state.dart';
import 'package:todo_shp_loc_cubit/widgets/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ky', 'KG'),
        Locale('ru', 'RU'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('ru', 'RU'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final _themeCubit = ThemeCubit();

  @override
  void dispose() {
    _themeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          if (state is ThemeisChanged) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: 'Flutter Demo',
              theme: ThemeData(
                brightness:
                    _themeCubit.lightTheme ? Brightness.light : Brightness.dark,
                primaryColor: Colors.lightBlue[800],
                primarySwatch: Colors.blueGrey,
                fontFamily: 'Georgia',
                textTheme: const TextTheme(
                  headline1: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro Text'),
                  headline6: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'SF Pro Text'),
                  bodyText2:
                      TextStyle(fontSize: 14.0, fontFamily: 'SF Pro Text'),
                ),
              ),
              home: const Home(),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
