import 'package:flutter/material.dart';
import 'package:todo/change.dart';

class createPage extends StatefulWidget {
  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              child: Text("メモ制作"),
        ),
        ),
    );
  }
}