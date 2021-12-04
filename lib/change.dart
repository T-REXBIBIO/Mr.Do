import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class changePage extends StatefulWidget{

  changePage({Key? key, this.MemoList = const [], required this.index}) : super(key: key);
  final List<Memo> MemoList;
  final int index;
  @override
  _changePageState createState() => _changePageState();
}

class _changePageState extends State<changePage> {

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Text("タイトル：" + widget.MemoList[widget.index].title,
            style: TextStyle(fontSize: 22),
            ),
            alignment: Alignment.center,
            width: 270.0,
            height: 65.0,
          ),
          Container(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "ここでメモのタイトルを変更できます。",
            ),
            maxLines: null,
          ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Text("料金・経費：" + result + "円",
              style: TextStyle(fontSize: 24),
            ),
            alignment: Alignment.center,
            width: 230.0,
            height: 65.0,
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "ここで料金・経費を変更できます。",
              ),
              maxLines: null,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Text("期限:" + Limit + "まで",
            style: TextStyle(fontSize: 20),
            ),
            alignment: Alignment.center,
            width: 300.0,
            height: 65.0,
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "ここで期限を変更できます。",
              ),
              maxLines: null,
            ),
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            child: Text("内容:\n" + widget.MemoList[widget.index].content,
            style: TextStyle(fontSize: 22),
            ),
              alignment: Alignment.topLeft,
              width: 270.0,
              height: 70.0
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "ここでメモの内容を変更できます。",
              ),
              maxLines: null,
            ),
          ),
          Container(
            child: RaisedButton.icon(
              icon: Icon(Icons.done),
              label: Text("保存"),
              color: Colors.lightGreen,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {

              },
            ),
          ),
          Container(
            child: RaisedButton.icon(
              icon: Icon(Icons.arrow_back),
              label: Text("メモに戻る"),
              color: Colors.amber,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
    ),
      );
  }
}