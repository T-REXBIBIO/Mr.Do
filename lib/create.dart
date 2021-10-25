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
        body: ListView(
          children: <Widget>[
          Container(
            child: Container(
              alignment: Alignment.center,
              child: Text("メモ作成", style: TextStyle(fontSize: 40),),
            ),
        ),
        Container(
          child: Text(
          ""
          )
        ),
        TextField(
        decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'メモの題名を入力してください',
        ),
        maxLines: null,
        ),
        Container(
          child: Text(
          ""
          )
        ),
        TextField(
        decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '完了までの期限を入力してください',
        ),
        maxLines: null,
        ),
            Container(
              child: Text(
              ""
              )
            ),
              TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '金額を入力してください',
              ),
              maxLines: null,
            ),
            Container(
              child: Text(
                  ""
              )
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'メモの内容を入力してください',
              ),
              maxLines: 5,
            ),
            Container(
              child: Text(
              ""
              )
            ),
        ],
              ),
            );
  }
}