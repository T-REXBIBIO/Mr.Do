import 'package:flutter/material.dart';
import 'package:todo/change.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit
        ),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => changePage(),
            ),
            );
          },
      ),
    );
  }
}
