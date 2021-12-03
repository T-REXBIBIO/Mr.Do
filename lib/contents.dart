import 'package:flutter/material.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:intl/intl.dart';
import 'package:todo/main.dart';
import 'package:todo/change.dart';


class ContentsPage extends StatefulWidget {
  ContentsPage({Key? key,this.MemoList = const [],required this.index}) : super(key: key);
  final int index;
  final List<Memo> MemoList;
  @override
  State<ContentsPage> createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {

  String get result {
    if (widget.MemoList[widget.index].price == 0) {
      return "金額が入力されていません";
    }
    int Price = widget.MemoList[widget.index].price;
    String Result = Price.toString();
    return Result;
  }

  String get Limit {
    if (widget.MemoList[widget.index].limit == null) {
      return "期限が入力されていません";
    }
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日H時mm分');
    return outputFormat.format(widget.MemoList[widget.index].limit);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      title: Text(widget.MemoList[widget.index].title)
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
      ),
            child: Text(Limit,
            style: TextStyle(fontSize: 20),
            ),
              width: 250.0,
              height: 65.0,
              alignment: Alignment.center,
            ),
            Container(
              child: Text(""),
            ),
            Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
    ),
            child: Text(result + "円",
            style: TextStyle(fontSize: 22),
            ),
              width: 250.0,
              height: 65.0,
              alignment: Alignment.center,
              ),
            Container(
              child: Text(""),
            ),
            Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
    ),
            child: Text(widget.MemoList[widget.index].content,
              style: TextStyle(fontSize: 18),
            ),
              width: 300.0,
              height: 150.0,
              alignment: Alignment.topLeft,
            ),
            Container(
              child: Text(""),
            ),
            Container(
              child: RaisedButton(
                child: const Text("Homeに戻る"),
                color: Colors.purple,
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
