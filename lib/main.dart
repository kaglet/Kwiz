import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: Home(),
    ));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'my first app',
        ),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Image.asset('assets/apparat-damonen.jpg'),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red.shade500,
              padding: EdgeInsets.all(30.0),
              child: Text('1'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.pink.shade400,
              padding: EdgeInsets.all(30.0),
              child: Text('2'),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.cyan,
              padding: EdgeInsets.all(30.0),
              child: Text('3'),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red[600],
        child: const Text(
          'click',
        ),
      ),
    );
  }
}
