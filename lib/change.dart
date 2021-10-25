import 'package:flutter/material.dart';

class changePage extends StatefulWidget{

  changePage({Key? key}) : super(key: key);

  @override
  _changePageState createState() => _changePageState();
}

class _changePageState extends State<changePage> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
      TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
      hintText: '編集画面です',
    ),
    maxLines: null,
      ),
        ],
    ),
      );
  }
}