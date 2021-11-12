import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:todo/contents.dart';
import 'package:todo/change.dart';
import 'package:todo/create.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  // 最初に表示するWidget
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'Doする君/Mr.Do',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.red,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {

  TodoListPage({ Key? key}) : super(key: key);

  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List<Memo> MemoList =[
    Memo(
        title: "メモのタイトル",
        content: "メモの内容",
        price: 0,
        limit: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      body: ListView.builder(
      itemCount: MemoList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(MemoList[index].title),
            subtitle: Text(MemoList[index].content),
            trailing: Icon(Icons.delete),
          ),
        );
      },
    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        //画面遷移
        onPressed: () async {
          final Memo = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => createPage(),
            ),
          );
          setState(() {
            MemoList.add(Memo);
          });
        },
      ),
    );
  }
}
//ここがメモ作成情報を受け取る場所
class Memo {
  Memo({
  required this.title,
  required this.content,
  required this.price,
  required this.limit,
  });
  String title;
  String content;
  int price;
  DateTime limit;
}