import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/contents.dart';
import 'package:todo/change.dart';
import 'package:todo/create.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class HouseBook extends StatefulWidget {
  HouseBook({Key? key}) : super(key: key);
  State<HouseBook> createState() => _HouseBook();
}

class _HouseBook extends State<HouseBook> {

  List<Memo> Pricelist = [];
  List priceList = [];
  int index = 0;

  //For文でPricelistの数だけ回す（足す）事をする
  String get result {
    if (Pricelist.isEmpty) {
      return "金額が入力されていません";
    }
    var sumPrice = 0;
    String sumString = "";
    for(final memo in Pricelist){
      sumPrice += memo.price;
      sumString = "合計" + sumPrice.toString() + "円";
    }
    return sumString;
  }

  Future<void> fetchTodoList() async {
    // Todo というコレクションに保存されているドキュメントをすべて取得する
    final snapshot = await FirebaseFirestore.instance.collection('Todo').get();
    Pricelist = snapshot.docs.map((doc) {
      final data = doc.data();
      final memo = Memo(
          title: data["title"],
          content: data["content"],
          price: data["price"],
          limit: (data["limit"] as Timestamp).toDate(),
          date: (data["date"] as Timestamp).toDate(),
          reference: doc.reference);
      return memo;
    }).toList();
    setState(() {}); // 画面を更新
  }

  @override
  void initState() {
    super.initState();
    fetchTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('経費一覧'),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
                Row(
                  children: [
                    FloatingActionButton.extended(
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      backgroundColor: Colors.red,
                      icon: Icon(Icons.home),
                      label: Text("戻る",
                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 15.0
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lime
        ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              border: Border.all(color: Colors.white)
            ),
            child: Text(result,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            height: 200,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Pricelist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(Pricelist[index].title),
                        subtitle: Text(Pricelist[index].price.toString()),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      ),
    );
  }
}

class Memo {
  Memo({
    required this.title,
    required this.content,
    required this.price,
    required this.limit,
    required this.date,
    required this.reference,
  });
  String title;
  String content;
  int price;
  DateTime limit;
  DateTime date;
  DocumentReference<Map<String, dynamic>>? reference;
}