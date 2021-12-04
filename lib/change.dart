import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  DateTime Date = DateTime.now();

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

  String get see {
    if(widget.MemoList[widget.index].limit == null){
      return '日付を選択してください。時計マークをタッチ→';
    }
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日H時mm分');
    return outputFormat.format(widget.MemoList[widget.index].limit!);
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 500,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              Container(
                height: 400,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      setState(() {
                        widget.MemoList[widget.index].limit = val;
                      });
                    }),
              ),

              // Close the modal
              CupertinoButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ));
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
              onChanged: (Title) {
                widget.MemoList[widget.index].title = Title;
              }
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
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "ここで料金・経費を変更できます。",
              ),
              maxLines: null,
                onChanged: (Price) {
                  widget.MemoList[widget.index].price = int.parse(Price);
                }
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
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(see),
                IconButton(
                  icon: Icon(Icons.schedule),
                  onPressed: () => _showDatePicker(context),
                ),
              ],
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
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
                onChanged: (Content) {
                  widget.MemoList[widget.index].content = Content;
                }
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
                widget.MemoList[widget.index].reference?.update({
                  "title": widget.MemoList[widget.index].title,
                  "content": widget.MemoList[widget.index].content,
                  "price": widget.MemoList[widget.index].price,
                  "limit": widget.MemoList[widget.index].limit,
                  "date": Date,
                });
                Navigator.popUntil(context, (route) => route.isFirst);
                setState(() {});
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