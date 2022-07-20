import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        tr('list_is_empty'),
        style: const TextStyle(fontSize: 20.0),
      ),
    );
  }
}
