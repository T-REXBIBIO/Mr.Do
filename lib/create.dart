import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/main.dart';

class createPage extends StatefulWidget {
  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> {

  String title = "";
  String content = "";
  int price = 0;
  DateTime limit = DateTime.now();

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
          onChanged: (Title){
          title = Title;
          setState(() {});
          },
        ),
        Container(
          child: Text(
          ""
          )
        ),
        //ここはDateTimePickerで作る
        TextField(
        decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: '完了までの期限を入力してください',
        ),
        maxLines: null,
            onChanged: (Limit){
              limit = Limit as DateTime;
              setState(() {});
            }
        ),
            Container(
              child: Text(
              ""
              )
            ),
              TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '金額を入力してください',
              ),
              maxLines: null,
                  onChanged: (Price){
                    price = int.parse(Price);
                    setState(() {});
                  }
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
              maxLines: 10,
                onChanged: (Content){
                  content = Content;
                  setState(() {});
                }
            ),
            Container(
              child: Text(
              ""
              )
            ),
            Container(
            child: ElevatedButton(
                    onPressed: () {
                    Navigator.of(context).pop(Memo(
                      title: title,
                      content: content,
                      price: price,
                      limit: limit
                    ));
                },
            child: Text("メモを保存"),
    )
            ),
        ],
              ),
            );
  }
}