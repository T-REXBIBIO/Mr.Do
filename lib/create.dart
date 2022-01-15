import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
      return '日付を選択してください。時計マークをタッチ→';
    }
    DateFormat outputFormat = DateFormat('yyyy年MM月dd日H時mm分');
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
      appBar: AppBar(
        title: Text("メモを追加します！"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.tealAccent
        ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(),
              ),
              hintText: 'メモのタイトルを入力してください',
            ),
            maxLines: null,
            onChanged: (Title) {
              title = Title;
            },
          ),
          ),
          //ここはDateTimePickerで作る
          Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
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
          ),
         Container(
           decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Colors.black),
             borderRadius: BorderRadius.circular(30),
           ),
         child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(),
                ),
                hintText: '金額を入力してください',
              ),
              maxLines: null,
              onChanged: (Price) {
                price = int.parse(Price);
              }
          ),
         ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30),
            ),
          child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(),
                ),
                hintText: 'メモの内容を入力してください',
              ),
              maxLines: 10,
              onChanged: (Content) {
                content = Content;
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
              )
          ),
          Container(
            child: RaisedButton.icon(
              icon: Icon(Icons.home),
              label: Text("Homeに戻る"),
            color: Colors.red,
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
      ),
    );
  }
}