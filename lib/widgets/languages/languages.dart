import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Languages extends StatelessWidget {
  const Languages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 77, 81, 85))),
          onPressed: () {
            context.setLocale(
              const Locale('ru', 'RU'),
            );
          },
          child: const Text('Русский'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 77, 81, 85))),
          onPressed: () {
            context.setLocale(
              const Locale('ky', 'KG'),
            );
          },
          child: const Text('Кыргызча'),
        ),
        TextButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 77, 81, 85))),
          onPressed: () {
            context.setLocale(const Locale('en', 'US'));
          },
          child: const Text('English'),
        ),
        // _LanguageButton(locale: const Locale('ru', 'RU'), language: 'Русский'),
        // _LanguageButton(locale: const Locale('ky', 'KG'), language: 'Кыргызча'),
        // _LanguageButton(locale: const Locale('en', 'US'), language: 'English'),
      ],
    );
  }
}

class LanguageButton extends StatelessWidget {
  final Locale locale;
  final String language;
  const LanguageButton({
    Key? key,
    required this.locale,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(255, 77, 81, 85))),
      onPressed: () {
        context.setLocale(locale);
      },
      child: Text(language),
    );
  }
}
