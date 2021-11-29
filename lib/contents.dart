import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:todo/main.dart';
import 'package:todo/change.dart';


class ContentsPage extends StatefulWidget {
  ContentsPage(List<Memo> memoList, {Key? key}) : super(key: key);

  @override
  State<ContentsPage> createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Text("メモのタイトル（title）"),
            Text("メモの期限（limit）"),
            Text("メモにかかるお金（price）"),
            Text("メモの本文（content）"),
            Container(
              child: RaisedButton(
                child: const Text("Homeに戻る"),
                color: Colors.red,
                shape: const StadiumBorder(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
            ]
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
