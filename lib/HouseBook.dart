import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/contents.dart';
import 'package:todo/change.dart';
import 'package:todo/create.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class HouseBook extends StatefulWidget {
  HouseBook({Key? key, this.MemoList = const [], required this.index}) : super(key: key);
  final List<Memo> MemoList;
  final int index;
  State<HouseBook> createState() => _HouseBook();
}

class _HouseBook extends State<HouseBook> {

  String get result {
    if (widget.MemoList[widget.index].price == 0) {
      return "金額が入力されていません";
    }
    int Price = widget.MemoList[widget.index].price;
    String Result = Price.toString();
    return Result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('経費一覧'),
      ),
      body: ListView.builder(
        itemCount: widget.MemoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(result),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}