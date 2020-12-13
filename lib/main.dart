// import 'package:Focus/parser/rss_parser.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:xml/xml.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus',
      theme: ThemeData(primaryColor: Colors.white),
      home: HomePage(title: "Focus on"),
    );
  }
}

// 第二个页面组件
class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New route"),
        ),
        body: HomePage());
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          SizedBox(
            width: 410,
            height: 20,
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Please input something...",
                  prefixIcon: Icon(Icons.search)),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Image.asset('assets/Tunnel.jpg'),
          FutureBuilder(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/package.json"),
              builder: (builder, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    var content = json.decode(snapshot.data);
                    return ItemList(content: content);

                    // return ListView.builder(
                    //     itemBuilder: (context, index) {
                    //       return Card(
                    //         child: Center(
                    //           child: Text("title is ${content[index]["name"]}"),
                    //         ),
                    //       );
                    //     },
                    //     itemCount: content == null ? 0 : content.length);
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
    @required this.content,
  }) : super(key: key);

  final content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: DisplayItem(item: content[index]),
        );
      },
      itemCount: content.length,
    ));
  }
}

class DisplayItem extends StatelessWidget {
  const DisplayItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final item;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
                  "${item["name"]}",
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.2,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                flex: 3),
            Expanded(
              child: Text("${item["degree"]}万热度",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey)),
              flex: 1,
            )
          ],
        ));
  }
}
