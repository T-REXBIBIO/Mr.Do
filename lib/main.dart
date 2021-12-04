import 'package:flutter/material.dart';
import 'package:todo/contents.dart';
import 'package:todo/change.dart';
import 'package:todo/create.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'JapaneseCupertinoLocalizations.dart' as jcl;
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // runAppを呼ぶ前に色々処理を行いたい時は初めにこれを書く必要がある。
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase の初期化。await をつけることで終わるまで待てる。
  await Firebase.initializeApp();

  // runApp のなかにかかれたWidgetがrootになります。
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
        primarySwatch: Colors.blue,
      ),
      // リスト一覧画面を表示
      home: TodoListPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        jcl.JapaneseCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ja', 'JP'),
      ],
      locale: Locale('ja', 'JP'),
    );
  }
}

// リスト一覧画面用Widget
class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Memo> MemoList = [];

  Future<void> fetchTodoList() async {
    // Todo というコレクションに保存されているドキュメントをすべて取得する
    final snapshot = await FirebaseFirestore.instance.collection('Todo').get();
    MemoList = snapshot.docs.map((doc) {
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
        title: Text('リスト一覧'),
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
                    icon: Icon(Icons.add),
                    label: Text("追加",
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: 15.0
                      ),
                    ),
                    onPressed: () async {
                      final Memo = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => createPage(),
                        ),
                      );
                      await fetchTodoList();
                      setState(() {});
                      },
                  ),
                ),
              ],
            ),
          ],
      ),
      body: ListView.builder(
        itemCount: MemoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(MemoList[index].title),
                  subtitle: Text(MemoList[index].content),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentsPage(MemoList: MemoList,index: index),
                      )
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    TextButton(
                    child: Text("削除"),
                    onPressed: () async {
                    //awaitを付けているのは同時に処理すると
                    //クラウド側の情報もなくなるため両方とも削除する対象がなくなり
                    //削除処理が走らなくなってしまうことを防ぐため
                    await MemoList[index].reference?.delete();
                    MemoList.removeAt(index);
                    setState(() {});
                    },
                    )
                  ],
                ),
              ],
            ),
          );
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
