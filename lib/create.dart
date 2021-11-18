import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/main.dart';

class createPage extends StatefulWidget {
  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> {

  String title = "";
  String content = "";
  int price = 0;
  DateTime? limit;
  DateTime date = DateTime.now();

  String get see {
    if(limit == null){
      return '日付を選択してください。';
    }
    DateFormat outputFormat = DateFormat('yyyy-MM-dd-H:mm');
    return outputFormat.format(limit!);
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
                        limit = val;
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
      body: ListView(
        children: <Widget>[
          Container(
            child: Container(
              alignment: Alignment.center,
              child: Text("メモを追加します！", style: TextStyle(fontSize: 40),),
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
            onChanged: (Title) {
              title = Title;
            },
          ),
          Container(
              child: Text(""),
          ),
          //ここはDateTimePickerで作る
          Container(
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
                color: Colors.black,
                width: 1,
              ),
            ),
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
              onChanged: (Price) {
                price = int.parse(Price);
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
              onChanged: (Content) {
                content = Content;
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
                  FirebaseFirestore.instance.collection("Todo").add({
                    "title": title,
                    "content": content,
                    "price": price,
                    "limit": limit,
                    "date": date,
                  },
                  );
                  Navigator.of(context).pop();
                },
                child: Text("メモを保存"),
              )
          ),
        ],
      ),
    );
  }
}