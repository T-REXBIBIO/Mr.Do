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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 125,
            padding: EdgeInsets.all(4),
            // childrenを指定してリスト表示
            child: ListView(
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.blue[600],
                  child: Text('テスト', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 35),),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => createPage(),
            ),
          );
        },
      ),
    );
  }
}