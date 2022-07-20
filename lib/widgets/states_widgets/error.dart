import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Что то пошло не так, попробуйте еще раз ... ',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
