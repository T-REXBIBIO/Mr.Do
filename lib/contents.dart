import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/main.dart';
import 'package:todo/change.dart';

class ContentsPage extends StatefulWidget {
  ContentsPage({Key? key,this.MemoList = const [], required this.index}) : super(key: key);
  final List<Memo> MemoList;
  final int index;
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
      title: Text(widget.MemoList[widget.index].title),
        actions: <Widget>[
      Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget> [
          SizedBox(
            height: 50.0,
            width: 100.0,
            child: FloatingActionButton.extended(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              backgroundColor: Colors.lightBlueAccent,
              icon: Icon(Icons.create),
              label: Text("変更",
                style: TextStyle(
                    color:Colors.black,
                    fontSize: 15.0
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => changePage(MemoList: widget.MemoList, index: widget.index),
                  ),
                );
                setState(() {});
              },
            ),
          ),
        ],
      ),
      ],
      ),
      body:Container(
      decoration: BoxDecoration(
      color: Colors.lightGreen
      ),
        child: Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 5),
              ),
              child: Text(Limit + "まで",
                style: TextStyle(fontSize: 20),
              ),
              width: 300.0,
              height: 65.0,
              alignment: Alignment.center,
            ),
            Container(
            decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(color: Colors.black, width: 5),
    ),
            child: Text(result + "円",
            style: TextStyle(fontSize: 22),
            ),
              width: 250.0,
              height: 65.0,
              alignment: Alignment.center,
              ),
            Container(
            decoration: BoxDecoration(
              color: Colors.white,
            border: Border.all(color: Colors.black, width: 5),
    ),
            child: Text(widget.MemoList[widget.index].content,
              style: TextStyle(fontSize: 18),
            ),
              width: 300.0,
              height: 150.0,
              alignment: Alignment.topLeft,
            ),
            Container(
              child: RaisedButton.icon(
                icon: Icon(Icons.home),
                label: Text("Homeに戻る"),
                color: Colors.purple,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
            ]
        ),// This trailing comma makes auto-formatting nicer for build methods.
      ),
    ),
    );
  }
}
